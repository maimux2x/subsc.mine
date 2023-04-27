require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it 'valid subscription data exist' do
    expect(build(:subscription)).to be_valid
  end

  it 'be invalid data to which the user is not linked' do
    subscription = build(:subscription, user: nil)
    subscription.valid?
    expect(subscription.errors[:user]).to include('を入力してください')
  end

  it 'service name is blank and invalid data' do
    subscription = build(:subscription, name: nil)
    subscription.valid?
    expect(subscription.errors[:name]).to include('を入力してください')
  end

  it 'subscription name must be 50 characters or less' do
    subscription = build(:subscription, name: 'a' * 50)
    subscription.valid?
    expect(subscription.errors[:name]).not_to include('は50文字以内で入力してください')

    long_name_subscription = build(:subscription, name: 'a' * 51)
    long_name_subscription.valid?
    expect(long_name_subscription.errors[:name]).to include('は50文字以内で入力してください')
  end

  it 'payment_date is blank and invalid data' do
    subscription = build(:subscription, payment_date: nil)
    subscription.valid?
    expect(subscription.errors[:payment_date]).to include('を入力してください')
  end

  it 'fee is blank and invalid data' do
    subscription = build(:subscription, fee: nil)
    subscription.valid?
    expect(subscription.errors[:fee]).to include('を入力してください')
  end

  it 'subscribed is blank and invalid data' do
    subscription = build(:subscription, subscribed: nil)
    subscription.valid?
    expect(subscription.errors[:subscribed]).to include('を入力してください')
  end

  it 'cycle is blank and invalid data' do
    subscription = build(:subscription, cycle: nil)
    subscription.valid?
    expect(subscription.errors[:cycle]).to include('を入力してください')
  end

  it 'payment date after this month is invalid' do
    valid_payment_date = Date.parse('2023/04/30')
    subscription = build(:subscription, payment_date: valid_payment_date)
    subscription.valid?
    expect(subscription.errors).not_to include('お支払基準日は今月以前の直近の日付を指定してください。')

    invalid_payment_date = Date.parse('2023/05/01')
    subscription = build(:subscription, payment_date: invalid_payment_date)
    subscription.valid?
    expect(subscription.errors).to include('お支払基準日は今月以前の直近の日付を指定してください。')
  end
end
