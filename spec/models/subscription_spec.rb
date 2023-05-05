# frozen_string_literal: true

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

  it 'my_account_url must be 200 characters or less' do
    subscription = build(:subscription, my_account_url: "https://#{'a' * 192}")
    subscription.valid?
    expect(subscription.errors[:my_account_url]).not_to include('は200文字以内で入力してください')

    long_url = build(:subscription, my_account_url: "https://#{'a' * 193}")
    long_url.valid?
    expect(long_url.errors[:my_account_url]).to include('は200文字以内で入力してください')
  end

  it 'cycle is blank and invalid data' do
    subscription = build(:subscription, cycle: nil)
    subscription.valid?
    expect(subscription.errors[:cycle]).to include('を入力してください')
  end

  it 'payment date after this month is invalid' do
    travel_to Time.zone.local(2023, 0o4, 16) do
      valid_payment_date = Date.parse('2023/04/30')
      subscription = build(:subscription, payment_date: valid_payment_date)
      subscription.valid?
      expect(subscription.errors[:payment_date]).not_to include('お支払基準日は今月以前の直近の日付を指定してください。')

      invalid_payment_date = Date.parse('2023/05/01')
      subscription = build(:subscription, payment_date: invalid_payment_date)
      subscription.valid?
      expect(subscription.errors[:payment_date]).to include('お支払基準日は今月以前の直近の日付を指定してください。')
    end
  end

  it 'the cycle is one month and the date one month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 0o4, 16) do
      valid_payment_date = Date.parse('2023/04/15')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 1)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-05-15 00:00:00 +0900'
    end
  end

  it 'the cycle is one month and the payment_date is after tommorow and the date one month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 0o5, 16) do
      valid_payment_date = Date.parse('2023/04/17')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 1)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-06-17 00:00:00 +0900'
    end
  end

  it 'the cycle is two month and the date two month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 0o4, 25) do
      valid_payment_date = Date.parse('2023/04/10')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 2)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-06-10 00:00:00 +0900'
    end
  end

  it 'the cycle is three month and the date three month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 0o4, 0o1) do
      valid_payment_date = Date.parse('2023/02/25')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 3)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-05-25 00:00:00 +0900'
    end
  end

  it 'the cycle is six month and the date six month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 0o4, 0o1) do
      valid_payment_date = Date.parse('2022/12/15')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 6)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-06-15 00:00:00 +0900'
    end
  end

  it 'the cycle is twelve month and the date twelve month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 0o4, 0o1) do
      valid_payment_date = Date.parse('2022/10/01')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 12)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-10-01 00:00:00 +0900'
    end
  end

  it 'the cycle is twelve month and the duration is 23 months and the date 23 month after the reference date is correct.' do
    travel_to Time.zone.local(2023, 10, 0o1) do
      valid_payment_date = Date.parse('2021/11/03')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 12)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2023-11-03 00:00:00 +0900'
    end
  end

  it 'the cycle is one month and the duration is 23 months and the date 23 month after the reference date is correct.' do
    travel_to Time.zone.local(2024, 10, 0o4) do
      valid_payment_date = Date.parse('2022/11/03')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 1)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2024-11-03 00:00:00 +0900'
    end
  end

  it 'the cycle is twelve month and the duration is 35 months and the date 35 month after the reference date is correct.' do
    travel_to Time.zone.local(2024, 10, 0o1) do
      valid_payment_date = Date.parse('2021/11/03')
      subscription = build(:subscription, payment_date: valid_payment_date, cycle: 12)
      next_payment_date = subscription.calc_next_payment_date

      expect(next_payment_date.to_s).to eq '2024-11-03 00:00:00 +0900'
    end
  end
end
