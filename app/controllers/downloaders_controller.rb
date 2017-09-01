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
    @file_path = "https:cloud.indie.hostremote.phpwebdavlocalhostdiscourse-2017-08-11-142637-v20170731030330.sql.gz"
    Jobs.enqueue(:send_download_next_link, file_path: @file_path)
    respond_to do |format|
      format.json {render json: @file_path}
      format.html {render html: @file_path}
    end
  end
end