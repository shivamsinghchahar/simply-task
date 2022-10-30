# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  validates :email, :first_name, :last_name, presence: true
  validates :first_name, :last_name, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }, format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }, allow_nil: true
  validates :password, presence: true, confirmation: true, length: { minimum: 6 }, allow_nil: true
  validates :password_confirmation, presence: true, allow_blank: true

  def name
    "#{first_name} #{last_name}"
  end
end
