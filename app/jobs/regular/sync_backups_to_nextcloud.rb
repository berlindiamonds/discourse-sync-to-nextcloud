module Jobs
  class SyncBackupsToNextcloud < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      many_backups = Backup.all.take(SiteSetting.discourse_sync_to_nextcloud_quantity)
      many_backups.each do |backup|
        DiscourseBackupToNextcloud::NextcloudSynchronizer.new(backup).sync
      end
    end
  end
end
