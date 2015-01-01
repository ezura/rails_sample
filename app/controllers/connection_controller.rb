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
      broadcast :modify, message
    end

    def update_version(version_dto)
      body = version_dto
      content = {
        head: "",
        body: body
      }
      broadcacst :update_version, content
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
        broadcast_message method, message
    end

end
