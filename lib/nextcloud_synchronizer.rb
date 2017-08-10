module DiscourseBackupToNextcloud
  class NextcloudSynchronizer < Synchronizer

    def initialize(backup)
      super(backup)
      @turned_on = SiteSetting.discourse_sync_to_nextcloud_enabled
    end

    def ocman
      ocman ||= Ocman.new
    end

    def can_sync?
      @turned_on && backup.present?
    end

    protected

    def perform_sync
      folder_name = Discourse.current_hostname
      full_path = backup.path
      filename = backup.filename
      file = ocman.put('#{full_path}', '/#{filename}')
      add_to_folder(file, folder_name)
    end

    def add_to_folder(file, folder_name)
      folder = ocman.list('/#{folder_name}')
      if folder.present?
        ocman.move('source_path/of/file', 'destination_path')
      else
        folder = ocman.create_folder('/#{folder_name}')
        ocman.move('source_path/of/file', 'destination_path')
      end
    end

    def remove_old_files(file, folder_name)
      next_files = ocman.list('/#{folder_name}/#{files}')
      sorted = next_files.sort_by {|x| x.created_time}
      keep = sorted.take(SiteSetting.discourse_sync_to_nextcloud_quantity)
      trash = next_files - keep
      trash.each { |d| d.delete }
    end

  end
end
