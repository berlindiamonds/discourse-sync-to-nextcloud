module Jobs
  class SyncBackupsToNextcloud < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      backups = Backup.all.take(SiteSetting.discourse_sync_to_nextcloud_quantity)
      backups.each do |backup|
        DiscourseBackupToNextcloud::NextcloudSynchronizer.new(backup).sync
      end
      DiscourseBackupToNextcloud::NextcloudSynchronizer.new(backups).delete_old_files
    end
  end
end