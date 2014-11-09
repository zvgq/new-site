(function() {
  define(["controllers/appcontroller"], function(ApplicationController) {
    return {
      setup: function() {
        return ZVGQBrowse.ApplicationController = ApplicationController;
      }
    };
  });

}).call(this);
