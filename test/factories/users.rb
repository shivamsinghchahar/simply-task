# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { "Sam" }
    last_name { "Smith" }
    email { "sam@example.com" }
    password_digest { BCrypt::Password.create("password") }
  end
end
