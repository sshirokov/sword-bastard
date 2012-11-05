require({
  baseUrl: '/app',
  deps: ['bootstrap'],

  paths: {
    // Libraries
    'shims': '/js/shims',
    'jquery': '/js/jquery.min',
    'bootstrap': '/js/bootstrap.min',
    'coffee-script': '/js/coffee-script',
    'easel': '/js/easeljs-0.5.0.min',
    'EventEmitter': '/js/EventEmitter',

    // Socket.IO isn't really a library
    'socket.io': '/socket.io/socket.io',

    // RequireJS plugins
    'cs': "/js/cs",
    'domReady': '/js/domReady'
  },

  shim: {
    'bootstrap': ['jquery'],

    'socket.io': {
      exports: 'io'
    },

    'easel': {
      exports: 'createjs'
    }
  }
}, ['domReady!', 'cs!index']);
