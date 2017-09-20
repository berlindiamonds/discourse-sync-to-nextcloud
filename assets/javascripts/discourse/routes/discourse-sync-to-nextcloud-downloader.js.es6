import { ajax } from 'discourse/lib/ajax';
import PreloadStore from 'preload-store';

export default Ember.Route.extend({
  model() {
    return ajax("/admin/plugins/discourse-sync-to-nextcloud/downloader.json");
  }
});
