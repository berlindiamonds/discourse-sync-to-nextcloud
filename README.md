# Discourse Sync to Nextcloud
A Plugin for Discourse that does a backup to your Nextcloud Account

1. Make sure you have the latest version of Discourse set up properly
2. Install the [basic-sync-plugin](https://github.com/berlindiamonds/discourse-sync-base) first
3. Clone this repository into your discourse/plugins folder
4. In the browser go to your Admin Settings and then to Plugins. You should see the discourse-sync-to-nextcloud appearing there

![alt text](https://user-images.githubusercontent.com/15628617/28319104-3839c696-6bcd-11e7-90dc-86513339190d.png)

5. Click in Settings and enable the plugin

![alt text](https://user-images.githubusercontent.com/15628617/28319119-44155a20-6bcd-11e7-9bfe-0e2154679ee6.png)

6. Pick one provider on [Nextcloud](https://nextcloud.com/providers/) and Sign up for an account.

7. In your `discourse-sync-to-nextcloud/config/initializers` folder create a new file called `ocman.rb` with the following code:
```
Ocman.configure do |config|
  config.base_url = 'https://put your provider url here.org'
  config.user_name = 'you username for the provider'
  config.password = 'your password'
end
```
and fill it out with your new credentials for the provider. Make sure you don't publish this file anywhere (eg. have it in the gitignore).

8. In your Discourse settings click on *backup* and make sure you have enough storage space.

This plugin was created by Jen and Kaja, in analogy to the [discourse-sync-to-dropbox plugin from Falco](https://github.com/xfalcox/discourse-backups-to-dropbox)

For help please go to [Discourse Meta](https://meta.discourse.org/)
