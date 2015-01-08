class Document < ActiveRecord::Base
  # version が更新されたら log にデータコピー
  # around_save :save_log
  after_create :create_first_log

  public
  #TODO: フレームワーク化するとき残しそう (結局全部 Public になったけど、今後の拡張で変わるかもなので今はこのままで)
    def to_json_for_public_info
      self.to_json(:only => [:document_id, :version, :contents, :meta, :version_name])
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
