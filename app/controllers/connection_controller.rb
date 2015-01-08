class ConnectionController < WebsocketRails::BaseController

    def initialize_session
      logger.debug("Session Initialized\n")
    end

    def connect_user
      logger.debug("connected user")
    end

    def checkout
      broadcast :checkout, message
    end

    def state
      broadcast :state, message
    end

    def modify
      resource_info = message
      create_new_version(resource_info) if create_new_version?(resource_info)
      save_resource(resource_info)
      broadcast :modify, message
    end

    def update_version(varsion)
      body = varsion
      content = {
        head: "",
        body: body
      }
      broadcast :update_version, content
      # TODO: 振り分け
    end

private
    def broadcast(method, content)
        message = {
          content: content
          # TODO: meta 情報を入れるかも
        }
        puts("broadcast: #{message}")
        WebsocketRails["#{content["resource_id"]}".to_sym].trigger(method, message)
        # broadcast_message method, message
    end

    def save_resource(resource_info)
      # FIXME: hash に格納して毎回検索しないようにする (ただし、なにも対策しないと分散DBの時に問題あるかも)
      document = Document.find_by(id: resource_info["resource_id"].to_i)
      puts resource_info["resource_id"]
      puts document.version
      log = Log.find_or_create_by(document_id: resource_info["resource_id"].to_i, version: document.version)
      puts log.version
      puts log
      contents = ActiveSupport::JSON.decode(log.contents)
      puts log.contents
      puts "-----"
      puts contents
      contents[resource_info["id"]] = resource_info["content"]
      puts contents
      log.contents = contents.to_json
      # log.contents = "{\"team\":\"rails\",\"players\":\"36\"}"
      log.save
    end

    # バージョンを新しく作るか
    def create_new_version?(resource_info)
      # TODO: 判定
      resource_info["content"].length % 10 == 0

    end

    def new_version_name(document)
      # TODO: 名前指定
      "version-#{document.version.to_s}"
    end

    def create_new_version(resource_info)
      # FIXME: DBの操作は違うところですべき
      begin
        Document.transaction {
          document = Document.find_by(id: resource_info["resource_id"].to_i)
          Log.transaction{
            old_log = Log.find_by(version: document.version)
            old_log.version_name = new_version_name(document)
            old_log.save!

            # TODO: contents の内容
            new_log = Log.new(document_id: document.id,
                              version: document.version+1,
                              contents: old_log.contents)
            new_log.save!
          }
          document.version += 1
          document.save!
        }
      rescue
        # TODO: エラーハンドリング
        logger.debug("error: create_new_version #{document}")
      end

      puts "create_new_version"
    end
end
