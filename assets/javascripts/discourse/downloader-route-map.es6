export default {
  resource: 'admin.adminPlugins',
  map() {
    this.route('discourse-sync-to-nextcloud', { resetNamespace: true }, function() {
      this.route('downloader');
    });
  }
};