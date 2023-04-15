FactoryBot.define do
  factory :subscription do
    user
    sequence(:name) { |i| "サブスクリプション名#{i}" }
    sequence(:payment_date) { rand(1..30).days.from_now }
    sequence(:fee) { 500 }
    sequence(:my_account_url) { |i| "https://example.com/#{i}" }
    sequence(:subscribed) { true }
    sequence(:cycle) { 1 }
  end
end
