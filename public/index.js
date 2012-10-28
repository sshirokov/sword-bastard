require({
  baseUrl: '/app',
  deps: ['bootstrap'],

  paths: {
    // Libraries
    'shims': '/js/shims',
    'jquery': '/js/jquery.min',
    'bootstrap': '/js/bootstrap.min',
    'coffee-script': '/js/coffee-script',

    // RequireJS plugins
    'cs': "/js/cs",
    'domReady': '/js/domReady'
  },

  shim: {
    'bootstrap': ['jquery']
  }
}, ['domReady!', 'cs!index']);
