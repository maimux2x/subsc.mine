FactoryBot.define do
  factory :subscription do
    user
    from = Date.parse("2023/04/01")
    to = Date.parse("2023/04/30")
    sequence(:name) { |i| "サブスクリプション名#{i}" }
    sequence(:payment_date) { Random.rand(from..to) }
    sequence(:fee) { rand(0..1_000_000) }
    sequence(:my_account_url) { |i| "https://example.com/#{i}" }
    sequence(:subscribed) { [true, false].sample }
    sequence(:cycle) { [1, 2, 3, 6, 12].sample }
  end
end
