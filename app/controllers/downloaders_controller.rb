require "email_backup_token"

class DownloadersController < ApplicationController
  skip_before_filter :check_xhr
  # skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def index
    next_list = DiscourseDownloadFromNextcloud::NextDownloader.new(nil).json_list

    respond_to do |format|
      format.json {render json: next_list}
      format.html {render html: next_list}
    end
  end

  def create
    @file_id = "0B7WjYjWZJv_4blA0a2p6RzVraFE"
    Jobs.enqueue(:send_download_next_link, file_id: @file_id)
    # respond_to do |format|
    #   format.json {render json: @file_id}
    #   format.html {render html: @file_id}
    # end
  end
end