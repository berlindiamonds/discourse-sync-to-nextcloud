module DiscourseBackupToNextcloud
  class NextcloudSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @turned_on = SiteSetting.discourse_sync_to_nextcloud_enabled
    end

    def ocman
    end

    def can_sync?
      @turned_on && backup.present?
    end

    def delete_old_files(file, folder_name)
      next_files = Ocman.list(folder_name)
      sorted = next_files.sort_by {|x| x.created_time}
      keep = sorted.take(SiteSetting.discourse_sync_to_nextcloud_quantity)
      trash = next_files - keep
      trash.each do |d|
        path = "/#{folder_name}" + d[:path].split(folder_name)[1]
        Ocman.delete(path)
      end
    end

    protected

    def perform_sync
      folder_name = Discourse.current_hostname
      begin
        Ocman.list(folder_name)
      rescue
        Ocman.create_folder(folder_name)
      end
      full_path = backup.path
      filename = backup.filename
      file = Ocman.put(full_path, folder_name)
    end
  end
end