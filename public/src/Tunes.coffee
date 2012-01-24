(($) ->

  window.Album = Backbone.Model.extend
    isFirstTrack: (index) ->
      return index == 0

    isLastTrack: (index) ->
      return index >= (@.get('tracks').length - 1)

    trackURLAtIndex: (index) ->
      if index < @.get('tracks').length
        @.get('tracks')[index].url
      else
        null

  window.Albums = Backbone.Collection.extend
    model: Album
    url: '/albums'

  window.AlbumView = Backbone.View.extend
    tagName: 'li'
    className: 'album'  
    
    initialize: ->
      _.bindAll(@, 'render')
      @.model.bind('change', @.render)
      @template = _.template($('#album-template').html())

    render: ->
      renderedContent = @template(@model.toJSON())
      $(@el).html(renderedContent)
      @

  window.LibraryAlbumView = AlbumView.extend({})

  window.LibraryView = Backbone.View.extend
    tagName: 'section'
    className: 'library'
    initialize: () ->
      _.bindAll(@, 'render')
      @.template = _.template($('#library-template').html())
      @.collection.bind('reset', @.render)

    render: () ->
      collection = @.collection
      $(@.el).html(@.template({}))
      $albums = @.$('.albums')
      collection.each (album) ->
        view = new LibraryAlbumView {model: album, collection: collection }
        $albums.append(view.render().el)
      @

)(jQuery)
