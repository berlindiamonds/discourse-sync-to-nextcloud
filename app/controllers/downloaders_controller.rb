require "email_backup_token"
require_relative "../jobs/regular/send_download_next_link.rb"


class DownloadersController < Admin::AdminController
  requires_plugin 'discourse-sync-to-nextcloud'
  skip_before_filter :check_xhr, only: [:show]

  def index
    next_list = DiscourseDownloadFromNextcloud::NextDownloader.new(nil).json_list
    render json: next_list
  end

  def create
    file_id = params.fetch(:file_id)
    file_path = DiscourseDownloadFromNextcloud::NextDownloader.new(file_id).download
    download_url = "#{url_for(controller: 'downloaders', action: 'show')}"
    Jobs.enqueue(:send_download_next_link, to_address: 'teamberlindiamonds@gmail.com', next_url: download_url)
    render nothing: true
  end

  def show
    file_id = params.fetch(:file_id)
    filename = DiscourseDownloadFromNextcloud::NextDownloader.new(file_id).filename
    file_path = File.join(Backup.base_directory, filename)
    send_file file_path
  end
end
