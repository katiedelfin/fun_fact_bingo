class FunFactsController < ApplicationController
  before_filter :find_fun_fact, only: [:edit, :update, :destroy]
  before_filter :enforce_fun_fact_limit, only: [:new, :create]

  def index
    @fun_facts = current_user.fun_facts
  end

  def new
    @fun_fact = current_user.fun_facts.build
  end

  def create
    @fun_fact = current_user.fun_facts.create(fun_fact_params)
    redirect_to fun_facts_url
  end

  def edit
  end

  def update
    @fun_fact.update_attributes(fun_fact_params)
    redirect_to fun_facts_url
  end

  def destroy
    @fun_fact.destroy
    redirect_to fun_facts_url
  end

  private

  def find_fun_fact
    @fun_fact = current_user.fun_facts.find(params[:id])
  end

  def fun_fact_params
    params.require(:fun_fact).permit(:text)
  end

  def enforce_fun_fact_limit
    if current_user.exceeds_fun_fact_limit?
      flash[:error] = "Hey you! You already have 2 facts, delete one if you want to add another."
      redirect_to :root
    end
  end
end
