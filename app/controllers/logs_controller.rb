class LogsController < ApplicationController
  before_action :set_log, only: [:update, :modify]

  # POST /logs/1
  # TODO: この時点でバージョン名付けるはず
  # TODO: DB のフックで上記処理する方が良い？
  def create
    @log = Log.new(log_params)
  end

  def update
    if @log.update(update_params)
      # TODO: ここで通知送る実装でもよいのか？
    else
      # TODO: クライアント側のロールバック？調停必要？
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_log
      @log = Log.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def log_params
      params.require(:log).permit(:document_id, :contents, :version, :meta, :version_name)
    end
end
