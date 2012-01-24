(($) ->

  window.Album = Backbone.Model.extend({})
  window.AlbumView = Backbone.View.extend(
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
  )

)(jQuery)
