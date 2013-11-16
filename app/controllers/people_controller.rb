class PeopleController < ApplicationController
  before_filter :get_client

  def index
    @current_page = (params[:page] || 1).to_i
    @people = @client.people.list(page: @current_page)
  end

  def edit
    @person = get_person(params[:id])
  end

  def update
    set_person(params[:id], params[:person])
    flash[:success] = "Updated person successfully"
    redirect_to edit_person_path(:id => params[:id])
  rescue OAuth2::Error => e # this should be not-an-oauth error now we're using the driver
    if e.response.parsed["code"] == "validation_failed"
      errors = e.response.parsed["validation_errors"]
      errors.each do |attr, failures|
        failures.each do |failure|
          "#{attr} is #{failure}"
        end
      end
      flash[:error] = array.join(" and ")
    else
      flash[:error] = "There was an error"
    end

    redirect_to edit_person_path(:id => params[:id])
  end

  private

  def get_client
    @client = credential.api_client
  end

  def get_person(id)
    Person.from_hash(@client.people.find(id).to_hash.stringify_keys)
  end

  def set_person(id, attributes)
    @client.people.save(NationBuilder::Model::Person.new(attributes))
    # options = {
    #   :headers => standard_headers,
    #   :body => {
    #     person: attributes
    #   }.to_json
    # }

    # token.put("/api/v1/people/#{id}", options)
  end
end
