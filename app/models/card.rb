class Card < ActiveRecord::Base
  validates :fun_fact_ids, uniqueness: true
end
