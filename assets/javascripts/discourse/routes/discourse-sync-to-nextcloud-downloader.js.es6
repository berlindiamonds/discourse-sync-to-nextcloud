import { ajax } from 'discourse/lib/ajax';

export default Ember.Route.extend({
  model() {
    return ajax("/admin/plugins/discourse-sync-to-googledrive/downloader.json");
  }
+});