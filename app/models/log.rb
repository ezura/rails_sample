class Log < ActiveRecord::Base
  public
  def to_json_for_public_info
    self.to_json(:only => [:document_id, :version, :contents, :meta, :version_name])
  end
end
