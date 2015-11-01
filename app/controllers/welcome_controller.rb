class WelcomeController < ApplicationController
  def index
    @companies = Company.all
    @people = Person.all
    render :index
  end
end
