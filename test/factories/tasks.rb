# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    user

    name { "Lorem Ipsum" }
    due_date { "2022-10-30" }
  end
end
