FactoryBot.define do
  factory :subscription do
    user
    sequence(:name) {|i| "サブスクリプション名"}    
    sequence(:payment_date) {|i| rand(1..30).days.from_now}    
    sequence(:fee) {|i| 500}    
    sequence(:my_account_url) {|i| "https://example.com/user"}    
    sequence(:subscribed) {|i| true}    
    sequence(:cycle) {|i| 1}    
  end
end
