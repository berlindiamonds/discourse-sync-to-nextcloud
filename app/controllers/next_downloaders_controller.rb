require "email_backup_token"
class NextDownloadersController < Admin::AdminController
  # requires_plugin 'discourse-sync-to-nextcloud'
  before_filter :check_xhr

  def index
    @next_list = DiscourseDownloadFromNextcloud::NextDownloader.new(nil).json_list
    render json: @next_list
  end

  def create
    @file_path = params[:file_path]
    # @file_path = "https:cloud.indie.hostremote.phpwebdavlocalhostdiscourse-2017-08-11-142637-v20170731030330.sql.gz"
    Jobs.enqueue(:send_download_next_link, file_path: @file_path)
    render json: @next_list
  end
end
