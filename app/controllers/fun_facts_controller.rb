require 'csv'

class FunFactsController < ApplicationController
  def import
    fun_fact_arrays = CSV.parse(File.open(params[:file].path), headers: false)

    fun_fact_arrays.each do |array|
      user = User.where(email: array.shift).first_or_create
      user.fun_facts.where(text: array.shift).first_or_create
      user.fun_facts.where(text: array.shift).first_or_create
    end

    Card.destroy_all

    User.count.times do
      Card.generate
    end

    redirect_to cards_path
  end
end
