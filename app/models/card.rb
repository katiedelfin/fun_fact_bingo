class Card < ActiveRecord::Base
  CARD_SIZE = 24

  validates :fun_fact_ids, uniqueness: true, length: { is: CARD_SIZE }, card_integrity: true

  def self.generate
    users = User.includes(:fun_facts).order("RANDOM()").limit(CARD_SIZE)
    random_fun_fact_ids = users.map do |user|
      user.fun_facts.shuffle[0].id
    end

    generated = false

    until generated
      generated_card = self.create(fun_fact_ids: random_fun_fact_ids)
      generated = generated_card.persisted?
    end

    generated_card
  end

  # Super inneficient but we need to maintain order
  def fun_facts
    @fun_facts ||= fun_fact_ids.map do |id|
      FunFact.find(id)
    end
  end

  def squares
    fun_facts.insert(fun_facts.length / 2, FunFact.new(text: "Free Space"))
  end
end
