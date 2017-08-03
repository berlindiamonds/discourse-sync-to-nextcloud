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
    end

  end
end
