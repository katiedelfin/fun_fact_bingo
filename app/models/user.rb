class User < ActiveRecord::Base
  has_many :fun_facts

  validates :email, presence: true
  validate :whitelisted_email, if: -> { self.class.email_whitelist? }

  def self.find_or_create_from_omniauth(auth)
    find_and_update_from_omniauth(auth) or create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.image = auth["info"]["image"]
    end
  end

  def self.find_and_update_from_omniauth(auth)
    find_by(auth.slice("provider","uid")).tap do |user|
      user && user.update_attribute(:image, auth["info"]["image"])
    end
  end

  def to_s
    self.name || self.email
  end

  def exceeds_fun_fact_limit?
    fun_facts.count >= FunFact::MAXIMUM_PER_USER
  end

  private

  def self.email_whitelist?
    !!ENV['EMAIL_WHITELIST']
  end

  def email_whitelist
    ENV["EMAIL_WHITELIST"].split(":")
  end

  def whitelisted_email
    if email_whitelist.none? { |email| self.email.include?(email) }
      errors.add(:email, "doesn't match the email domain whitelist: #{email_whitelist}")
    end
  end
end
