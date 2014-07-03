class EventsController < ApplicationController
  #before_filter :authenticate_user!

  def index
    respond_to do |format|
      format.html { render 'events/index' }
      format.json { render 'public/test_events.json' }
    end
  end
end
