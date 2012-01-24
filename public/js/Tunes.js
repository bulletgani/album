
(function($) {
  window.Album = Backbone.Model.extend({
    isFirstTrack: function(index) {
      return index === 0;
    },
    isLastTrack: function(index) {
      return index >= (this.get('tracks').length - 1);
    },
    trackURLAtIndex: function(index) {
      if (index < this.get('tracks').length) {
        return this.get('tracks')[index].url;
      } else {
        return null;
      }
    }
  });
  window.Albums = Backbone.Collection.extend({
    model: Album,
    url: '/albums'
  });
  window.library = new Albums();
  window.AlbumView = Backbone.View.extend({
    tagName: 'li',
    className: 'album',
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      return this.template = _.template($('#album-template').html());
    },
    render: function() {
      var renderedContent;
      renderedContent = this.template(this.model.toJSON());
      $(this.el).html(renderedContent);
      return this;
    }
  });
  window.LibraryAlbumView = AlbumView.extend({});
  window.LibraryView = Backbone.View.extend({
    tagName: 'section',
    className: 'library',
    initialize: function() {
      _.bindAll(this, 'render');
      this.template = _.template($('#library-template').html());
      return this.collection.bind('reset', this.render);
    },
    render: function() {
      var $albums, collection;
      collection = this.collection;
      $(this.el).html(this.template({}));
      $albums = this.$('.albums');
      collection.each(function(album) {
        var view;
        view = new LibraryAlbumView({
          model: album,
          collection: collection
        });
        return $albums.append(view.render().el);
      });
      return this;
    }
  });
  window.BackboneTunes = Backbone.Router.extend({
    routes: {
      "": 'home',
      'blank': 'blank'
    },
    initialize: function() {
      return this.libraryView = new LibraryView({
        collection: window.library
      });
    },
    home: function() {
      var $container;
      $container = $('#container');
      $container.empty();
      return $container.append(this.libraryView.render().el);
    },
    blank: function() {
      return $container.empty();
    }
  });
  return $(function() {
    window.App = new BackboneTunes();
    return Backbone.history.start();
  });
})(jQuery);
