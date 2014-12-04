class Document < ActiveRecord::Base
  # version が更新されたら log にデータコピー
  around_save :save_log

  public
  #TODO: フレームワーク化するとき残しそう (結局全部 Public になったけど、今後の拡張で変わるかもなので今はこのままで)
    def to_json_for_public_info
      self.to_json(:only => [:document_id, :version, :contents, :meta, :previous_version, :next_version])
    end

  protected
    def save_log
      prev_version = self.previous_version
      yield
      log = Log.create(
        document_id:      self.id,
        version:          self.previous_version,
        contents:         self.contents,
        meta:             self.meta,
        previous_version: prev_version,
        next_version:     self.version
      )
      # TODO: 保存できなかったときの例外処理
      logger.debug(log)
    end
end
