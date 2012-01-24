
(function($) {
  window.Album = Backbone.Model.extend({});
  return window.AlbumView = Backbone.View.extend({
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
})(jQuery);
