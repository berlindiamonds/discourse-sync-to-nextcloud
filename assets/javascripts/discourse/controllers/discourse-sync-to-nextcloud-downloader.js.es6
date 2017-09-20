import { ajax } from 'discourse/lib/ajax';

export default Ember.Controller.extend({
  actions: {
    test() {
      alert('button clicked');
    },

    download(file) {
      ajax("/admin/plugins/discourse-sync-to-nextcloud/downloader/" + file.file_id, { type: "PUT" })
      .then(() => {
        bootbox.alert(I18n.t("admin.backups.operations.download.alert"));
      });
    }
  }
});