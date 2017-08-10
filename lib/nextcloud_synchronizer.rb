module DiscourseBackupToNextcloud
  class NextcloudSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @api_key = SiteSetting.discourse_sync_to_nextcloud_api_key
      @turned_on = SiteSetting.discourse_sync_to_nextcloud_enabled
    end

    def session
    end

    def can_sync?
      @turned_on && @api_key.present? && backup.present?
    end

    protected

    def perform_sync
      folder_name = Discourse.current_hostname
      full_path = backup.path
      filename = backup.filename
      file = Ocman.put('#{full_path}', '/#{filename}')
      add_to_folder(file, folder_name)
    end

    def add_to_folder(file, folder_name)
      folder = Ocman.list('/#{folder_name}')
      if folder.present?
        Ocman.move('source_path/of/file', 'destination_path')
      else
        folder = Ocman.create_folder('/#{folder_name}')
        Ocman.move('source_path/of/file', 'destination_path')
      end
    end

    def remove_old_files(file, folder_name)
      next_files = Ocman.list('/#{folder_name}/#{files}')
      sorted = next_files.sort_by {|x| x.created_time}
      keep = sorted.take(SiteSetting.discourse_sync_to_googledrive_quantity)
      trash = next_files - keep
      trash.each { |d| d.delete }
    end

  end
end
