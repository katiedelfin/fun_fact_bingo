class Card < ActiveRecord::Base
  validates :fun_fact_ids, uniqueness: true, length: { is: 50 }, card_integrity: true

  def self.generate
    users = User.includes(:fun_facts).order("RANDOM()").limit(50)
    random_fun_fact_ids = users.map do |user|
      user.fun_facts.shuffle[0].id
    end

    self.create(fun_fact_ids: random_fun_fact_ids)
  end

  # Super inneficient but we need to maintain order
  def fun_facts
    fun_fact_ids.map do |id|
      FunFact.find(id)
    end
  end
end
