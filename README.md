# Discourse Sync to Nextcloud ☁️
A Plugin for [Discourse](https://www.discourse.org) that does a backup to your [Nextcloud](https://nextcloud.com) account

1. Make sure you have the latest version of Discourse set up properly
2. Install the [basic-sync-plugin](https://github.com/berlindiamonds/discourse-sync-base) first
3. Clone this repository into your discourse/plugins folder
4. In the browser go to your Admin Settings and then to Plugins. You should see the discourse-sync-to-nextcloud appearing there

![alt text](https://user-images.githubusercontent.com/15628617/29270789-aa99ef82-80f8-11e7-86c9-6eda1998c19c.png)

5. Click in Settings and enable the plugin. Choose the quantity of backups you want to synchronize.

![alt text](https://user-images.githubusercontent.com/15628617/29270795-b34d084e-80f8-11e7-8dd2-40a5ee90098a.png)

6. Pick a [Nextcloud provider](https://nextcloud.com/providers/) and sign up for an account. You can also [install your own Nextcloud server](https://nextcloud.com/install/#instructions-server).

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
