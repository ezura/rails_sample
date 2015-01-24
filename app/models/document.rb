class Document < ActiveRecord::Base
  has_many :log

  # version が更新されたら log にデータコピー
  # around_save :save_log
  after_create :create_first_log

  public
    def self.resource_by_id_and_version_name(id, version_name)
      log = Log.find_by(document_id: id, version_name: version).to_json_for_public_info(:include => true)
      puts log
    end

  #TODO: フレームワーク化するとき残しそう (結局全部 Public になったけど、今後の拡張で変わるかもなので今はこのままで)
    def to_json_for_public_info
      self.to_json(:only => [:tmp, :version, :contents, :meta])
    end

  protected
    def save_log
      version = self.version + 1
      yield
      log = Log.create(
        document_id:      self.id,
        version:          version,
        contents:         self.contents,
        meta:             self.meta,
        version_name:     "log" + "_" + version.to_s
      )
      # TODO: 保存できなかったときの例外処理 (可能性としては、保存する前に新しいログの保存要求がきて、
      # version の unique 制約にひっかかるなど)
      logger.debug(log)
    end

    def create_first_log
      log = Log.create(
      document_id:      self.id,
      version:          self.version,
      contents:         "{}",
      meta:             self.meta,
      # TODO: version name 作る関数呼ぶ
      version_name:     "log" + "_" + version.to_s
      )
      # TODO: 保存できなかったときの例外処理 (可能性としては、保存する前に新しいログの保存要求がきて、
      # version の unique 制約にひっかかるなど)
      logger.debug(log)
    end
end
