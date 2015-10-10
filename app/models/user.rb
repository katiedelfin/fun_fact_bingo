class User < ActiveRecord::Base
  has_many :fun_facts

  validates :email, presence: true
end
