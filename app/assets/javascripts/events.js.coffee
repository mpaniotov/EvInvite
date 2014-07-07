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
      start_date = new Date(@model.get('start_time').replace(/-/g, "/"));
      $(@el).find('.start_time').html start_date.strftime("%H:%M, %A %d %B %Y");
      end_date = new Date(@model.get('end_time').replace(/-/g, "/"));
      $(@el).find('.end_time').html end_date.strftime("%H:%M, %A %d %B %Y");
      this

  LibraryEventView = EventView.extend
    events: ->
      'click .event-title':'select'
      'click .delete-event':'delete'

    select: ->
      $('.event-message').not($(@el).find('.event-message')).stop().hide('slow');
      $(@el).find('.event-message').stop().toggle('slow');
      return

    delete: ->
      $(@el).hide('slow');
      return

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


  handler = Gmaps.build("Google")
  handler.buildMap
    internal:
      id: "multi_markers"
  , ->
    markers = handler.addMarkers([
      {
        lat: 43
        lng: 3.5
      }
      {
        lat: 45
        lng: 4
      }
    ])
    handler.bounds.extendWith markers
    handler.fitMapToBounds()
    return

