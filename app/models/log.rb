class Log < ActiveRecord::Base
  belongs_to :document

  after_create :notify_named_version
  public
  def to_json_for_public_info(include: false)
    # FIXME: もっと良い書き方
    if include == true
      self.to_json(:only => [:document_id, :version, :contents, :meta, :version_name], :include =>:document)
    else
      self.to_json(:only => [:document_id, :version, :contents, :meta, :version_name])
    end
  end

  def previous_version_name
    return "" if self.version == 0

    previous_version = Log.select(:version_name).where("document_id = #{self.document_id} and version = #{self.version-1}").limit(1).first
    puts previous_version.version_name
    previous_version.version_name
  end

  def next_version_name
    next_version = Log.select(:version_name).where("document_id = #{self.document_id} and version = #{self.version+1}").limit(1).first

    return "" if next_version == nil
    puts next_version.version_name
    next_version.version_name
  end

  def uri_for_version(version)
    return "" if version == nil
    Rails.application.routes.url_helpers.document_history_url(id: self.document_id, version_name: version, host: "localhost:3100")
  end

  def notify_named_version
    puts "--notify_create_version"
    ConnectionController.notify_named_version(self.document_id, previous_version_name)
  end
end
