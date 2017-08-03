# name: discourse-sync-to-nextcloud
# about: -
# version: 1.0
# authors: Kaja & Jen
# url: https://github.com/berlindiamonds/discourse-sync-to-nextcloud

# GEMS

enabled_site_setting :discourse_sync_to_nextcloud_enabled

after_initialize do
  load File.expand_path("../app/jobs/regular/sync_backups_to_nextcloud.rb", __FILE__)
  load File.expand_path("../lib/nextcloud_synchronizer.rb", __FILE__)

  Backup.class_eval do
    def after_create_hook
      Jobs.enqueue(:sync_backups_to_nextcloud)
    end
  end
end
