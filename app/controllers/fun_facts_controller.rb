require 'csv'

class FunFactsController < ApplicationController
  def import
    fun_fact_arrays = CSV.parse(File.open(params[:file].path), headers: false)

    fun_fact_arrays.each do |array|
      user = User.where(email: array.shift).first_or_create
      user.fun_facts.create(text: array.shift)
      user.fun_facts.create(text: array.shift)
    end

    User.count.times do
      Card.generate
    end

    redirect_to cards_path
  end
end
