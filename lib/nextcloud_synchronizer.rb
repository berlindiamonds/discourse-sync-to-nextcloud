module DiscourseBackupToNextcloud
  class NextcloudSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @turned_on = SiteSetting.discourse_sync_to_nextcloud_enabled
    end

    def can_sync?
      @turned_on && backup.present?
    end

    def delete_old_files
      folder_name = Discourse.current_hostname
      next_files = Ocman.list(folder_name)
      sorted = next_files.sort_by { |x| x.created_time }
      keep = next_files.take(SiteSetting.discourse_sync_to_nextcloud_quantity)
      trash = next_files - keep
      trash.each do |f|
        old_files = "/#{folder_name}/#{f.path}"
        Ocman.delete(old_files)
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
      unless file_already_there?(folder_name, filename)
        Ocman.put(full_path, folder_name)
      end
    end

    def file_already_there?(folder_name, filename)
      remote_files = Ocman.list(folder_name)
      file = []
      remote_files.each do |pick|
        file << pick[:path].split(folder_name)[1]
      end
      file.include?(filename)
    end

  end
end
