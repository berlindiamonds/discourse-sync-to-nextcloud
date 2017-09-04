require "email_backup_token"
class NextDownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-nextcloud'

  def index
    next_list = DiscourseDownloadFromNextcloud::NextDownloader.new(nil).json_list
    render json: next_list
  end

  def create
    @file_path = "https:cloud.indie.hostremote.phpwebdavlocalhostdiscourse-2017-08-11-142637-v20170731030330.sql.gz"
    Jobs.enqueue(:send_download_next_link, file_path: @file_path)
    render json: @file_path
  end
end
