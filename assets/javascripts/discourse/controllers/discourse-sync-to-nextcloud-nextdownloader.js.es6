export default Ember.Controller.extend({
  actions: {
    test() {
      alert('buttone clicked');
    },

    download(backup) {
      let link = backup.get('title');
      ajax("/admin/plugins/discourse-sync-to-nextcloud/nextdownloader/" + link, { type: "PUT" })
      .then(() => {
        bootbox.alert(I18n.t("admin.backups.operations.download.alert"));
      });
    }
  }
});