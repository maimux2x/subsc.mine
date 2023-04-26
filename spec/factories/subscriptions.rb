FactoryBot.define do
  factory :subscription do
    user
    start_month = Date.parse("2023/04/01")
    end_month = Date.parse("2023/04/30")
    sequence(:name) { |i| "サブスクリプション名#{i}" }
    sequence(:payment_date) { Random.rand(start_month..end_mont) }
    sequence(:fee) { rand(0..1000000) }
    sequence(:my_account_url) { |i| "https://example.com/#{i}" }
    sequence(:subscribed) { true }
    sequence(:cycle) { [1, 2, 3, 6, 12].sample }
  end
end
