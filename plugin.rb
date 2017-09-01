# name: discourse-sync-to-nextcloud
# about: -
# version: 1.0
# authors: Kaja & Jen
# url: https://github.com/berlindiamonds/discourse-sync-to-nextcloud

add_admin_route 'nextfiles.title', 'nextfiles'

Discourse::Application.routes.append do
  get '/admin/plugins/discourse-sync-to-nextcloud/nextfiles' => 'admin/plugins#index'
end

# GEMS
gem 'domain_name', '0.5.20170404', { require: false }
gem 'http-cookie', '1.0.3', { require: false }
gem 'hashie', '3.5.5', { require: false }
gem 'multi_json', '1.12.1', { require: false }
gem 'net_dav', '0.5.1', { require: false }
gem 'netrc', '0.8.0', { require: false }
gem 'rest-client', '2.0.2', { require: false }
gem 'ocman', '1.2.2'
require 'sidekiq'

enabled_site_setting :discourse_sync_to_nextcloud_enabled

after_initialize do
  load File.expand_path("./plugins/discourse-sync-to-nextcloud/config/initializers/ocman.rb")
  load File.expand_path("../app/jobs/regular/sync_backups_to_nextcloud.rb", __FILE__)
  load File.expand_path("../lib/nextcloud_synchronizer.rb", __FILE__)

  load File.expand_path("./plugins/discourse-sync-to-nextcloud/assets/javascripts/discourse/nextfiles-route-map.js.es6")

  DiscourseEvent.on(:backup_created) do
    Jobs.enqueue(:sync_backups_to_nextcloud)
  end
end
