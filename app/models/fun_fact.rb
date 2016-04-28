class FunFact < ActiveRecord::Base
  MAXIMUM_PER_USER = 2

  belongs_to :user

  validates :user, presence: true
  validates :text, presence: true
end
