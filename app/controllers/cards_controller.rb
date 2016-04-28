class CardsController < ApplicationController
  before_filter :authorize_admin!

  def index
    @cards = Card.all
  end

  def regen
    if FunFact.count >= Card::CARD_SIZE
      Card.destroy_all

      User.count.times do
        Card.generate
      end
    else
      flash[:error] = "Not enough fun facts to re-generate cards."
    end

    redirect_to :root
  end
end
