import { ajax } from 'discourse/lib/ajax';

export default Ember.Controller.extend({
  actions: {
    test() {
      alert('buttone clicked');
    },

    download(file) {
      ajax("/admin/plugins/discourse-sync-to-nextcloud/nextdownloader/" + file.file_path, { type: "PUT" })
      .then(() => {
        bootbox.alert(I18n.t("admin.backups.operations.download.alert"));
      });
    }
  }
});