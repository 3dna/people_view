class PeopleController < ApplicationController
  before_filter :get_client

  def index
    @current_page = (params[:page] || 1).to_i
    @people = @client.people.list(page: @current_page)
  end

  def edit
    @person = Person.from_hash(@client.people.find(params[:id]).to_hash.stringify_keys)
  end

  def update
    person = NationBuilder::Model::Person.new(params[:person])
    if @client.people.save(person)
      flash[:success] = "Updated person successfully"
      redirect_to edit_person_path(:id => params[:id])
    else
      flash[:error] = person.errors.full_messages
      render :edit
    end
  end

  private

  def get_client
    @client = credential.api_client
  end
end
