class CardIntegrityValidator < ActiveModel::Validator
  def validate(record)
    fun_fact_ids = record.fun_fact_ids
    fun_facts = record.fun_facts

    # Unique set of facts
    if fun_fact_ids.uniq.length != fun_fact_ids.length
      record.errors[:fun_fact_ids] << "are not unique"
    end

    # Unique set of users
    if fun_facts.map(&:user_id).uniq.length != fun_facts.length
      record.errors[:fun_fact_ids] << "are not from unique users"
    end
  end
end
