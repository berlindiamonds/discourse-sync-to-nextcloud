module Jobs
  class SyncBackupsToNextcloud < ::Jobs::Base

    sidekiq_options queue: 'low'

    def execute(arg)
      backups = Backup.all.take(SiteSetting.discourse_sync_to_nextcloud_quantity)
      backups.each do |backup|
        DiscourseBackupToNextcloud::NextcloudSynchronizer.new(backup).sync
      end
    end
  end
end
