export default Ember.Controller.extend({
  nextfilesVisible: false,

  actions: {
    showNextfiles() {
      this.set('nextfilesVisible', true);
    }
  }
});