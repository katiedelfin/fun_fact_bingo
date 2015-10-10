class HomeController < ApplicationController
  def index
  end

  def nuke
    User.destroy_all
    FunFact.destroy_all
    Card.destroy_all

    redirect_to :root
  end
end
