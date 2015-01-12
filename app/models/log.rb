class Log < ActiveRecord::Base
  public
  def to_json_for_public_info
    self.to_json(:only => [:document_id, :version, :contents, :meta, :version_name])
  end

  def previous_version_name
    return "" if self.version == 0

    previous_version = Log.select(:version_name).where("document_id = #{self.document_id} and version = #{self.version-1}").limit(1).first
    puts previous_version.version_name
    previous_version.version_name
  end

  def next_version_name
    next_version = Log.select(:version_name).where("document_id = #{self.document_id} and version = #{self.version+1}").limit(1).first
    puts next_version.version_name
    next_version.version_name
  end

  def uri_for_version(version)
    Rails.application.routes.url_helpers.document_history_url(id: self.document_id, version_name: version, host: "localhost:3100")
  end
end
