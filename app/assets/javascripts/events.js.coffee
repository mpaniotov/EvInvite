# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  window.Event = Backbone.Model.extend()

  Events = Backbone.Collection.extend
    model: Event
    url: '/test_events'

  EventView = Backbone.View.extend
    template: _.template($("#event-template").html())
    className: 'event'
    initialize: ->
      _.bindAll this, 'render'
      @model.bind "change", @render
      @template = _.template($('#event-template').html())

    render: ->
      renderedContent = @template(@model.toJSON())
      $(@el).html renderedContent
      this

  LibraryEventView = EventView.extend
    events: ->
      'click .queue.add':'select'

    select: ->
      @collection.trigger('select', @model)

  LibraryView = Backbone.View.extend
    tagName: 'section'
    className: 'library'
    initialize: ->
      _.bindAll this, 'render'
      @template = _.template($('#library-template').html())
      @collection.bind('reset', @render)

    render: ->
      $events = @collection
      collection = @collection
      $(@el).html(@template())
      $events = @$('.events')
      collection.each (event) ->
        view = new LibraryEventView(model: event,collection: collection)
        $events.append(view.render().el)
      this


  library = new Events
  libraryView = new LibraryView({collection: library})
  $('.container').append(libraryView.render().el)

  library.fetch()

  displayOnMap = (position) ->
    marker = handler.addMarker(
      lat: position.coords.latitude
      lng: position.coords.longitude
    )
    handler.map.centerOn marker
    return
  handler = Gmaps.build("Google")
  handler.buildMap
    internal:
      id: "geolocation"
  , ->
    navigator.geolocation.getCurrentPosition displayOnMap  if navigator.geolocation
    return


