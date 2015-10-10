class Card < ActiveRecord::Base
  validates :fun_fact_ids, uniqueness: true, length: { is: 50 }, card_integrity: true

  def fun_facts
    FunFact.where(id: fun_fact_ids)
  end
end 
