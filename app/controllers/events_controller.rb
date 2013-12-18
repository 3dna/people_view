class EventsController < ApplicationController
  before_filter :get_client

  def index
    @current_page = (params[:page] || 1).to_i
    @events = @client.sites['abeforprez'].events.list(page: @current_page)
  end

  private

  def get_client
    @client = credential.api_client
  end
end
