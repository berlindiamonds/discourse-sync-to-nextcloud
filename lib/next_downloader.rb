module DiscourseDownloadFromNextcloud
  class NextDownloader

    attr_accessor :next_files, :file_path

    def initialize(file_path)
      @file_path = pick_file(file_path)
      @api_key = SiteSetting.discourse_sync_to_googledrive_api_key
      @turned_on = SiteSetting.discourse_sync_to_googledrive_enabled
    end

    def can_download?
      @turned_on && @file_path.present?
    end

    def next_files
      folder_name = Discourse.current_hostname
      @next_files ||= Ocman.list(folder_name)
    end

    def json_list
      folder_name = Discourse.current_hostname
      list_files = next_files.map do |o|
        {title: o[:path].split(folder_name)[1], file_path: o[:path], size: o[:size], created_at: o[:path].split("discourse")[1].split("-")[0..3]}
      end
      {"files" => list_files}.to_json
    end

    def pick_file(file_path)
      @file_path = "https:cloud.indie.hostremote.phpwebdavlocalhostdiscourse-2017-08-11-142637-v20170731030330.sql.gz"
      # click on a file from JsonFile sends a POST :file_path to create
      # something like a <%= select_tag(:file_path) %>
      # pick by file_path from the view
      # next_files.file_path(picked)
      # returns file_path
    end

    def create_url
      folder_name = Discourse.current_hostname
      found = next_files.select { |f| f[:path] == file_path }
      file_title = found.first.title
      file_url = Ocman.list(folder_name).share
    end
  end
end