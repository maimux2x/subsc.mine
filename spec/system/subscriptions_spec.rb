# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Subscriptions', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'subscription list screen' do
    let!(:subscription_of_user) { create(:subscription, name: 'ログイン中のユーザーが登録したサブスク', user:) }
    let!(:subscription_of_other_user) { create(:subscription, name: '他のユーザーが登録したサブスク', user: other_user) }

    context 'list correct users subscription' do
      it 'list login users subscription' do
        sign_in_as(user)
        expect(page).to have_content 'ログイン中のユーザーが登録したサブスク'
      end

      it 'not list other users subscription' do
        sign_in_as(user)
        expect(page).not_to have_content '他のユーザーが登録したサブスク'
        expect(current_path).to eq subscriptions_path
      end
    end

    describe 'subscription submit screen' do
      context 'fill in all data' do
        it 'subscription is submitted' do
          sign_in_as(user)
          click_button '新規登録'

          fill_in 'サービス名', with: '最初のサブスク'
          fill_in 'お支払基準日', with: DateTime.new(2023, 4, 1, 10, 30)
          fill_in 'お支払金額', with: 1000
          fill_in 'マイアカウント', with: 'https://example.com/user'
          select '継続中', from: 'ステータス'
          select '1ヶ月毎', from: '周期'
          click_button '登録する'

          expect(page).to have_selector '.notification', text: 'サブスクリプション「最初のサブスク」を登録しました'
          expect(page).to have_content '最初のサブスク'
        end
      end

      context 'forgot fill in service name' do
        it 'subscription is not submitted' do
          sign_in_as(user)
          click_button '新規登録'
          fill_in 'サービス名', with: ''
          fill_in 'お支払基準日', with: DateTime.new(2023, 4, 1, 10, 30)
          fill_in 'お支払金額', with: 1000
          fill_in 'マイアカウント', with: 'https://example.com/user'
          select '継続中', from: 'ステータス'
          select '1ヶ月毎', from: '周期'
          click_button '登録する'

          expect(page).to have_content 'サービス名を入力してください'
        end
      end
    end

    describe 'subscription edit screen' do
      let(:users_subscription) { create(:subscription, name: 'サービス名の変更', user:) }

      context 'fill in all data' do
        it 'user can edit subscription' do
          sign_in_as(user)
          visit edit_subscription_path(users_subscription)

          fill_in 'サービス名', with: '変更後のサービス名'
          click_button '更新する'

          expect(page).to have_selector '.notification', text: 'サブスクリプション「変更後のサービス名」を編集しました。'
          expect(page).to have_content '変更後のサービス名'
        end
      end

      context 'forgot fill in service name' do
        it 'user can not edit subscription' do
          sign_in_as(user)
          visit edit_subscription_path(users_subscription)

          fill_in 'サービス名', with: ''
          click_button '更新する'

          expect(page).to have_content 'サービス名を入力してください'
        end
      end
    end

    describe 'delete subscription' do
      # 一覧画面の構成が複数の削除ボタンが存在するため、サブスクのデータが1個であることを前提にテストする
      context 'exist only one subscription' do
        it 'user can delete subscription', js: true do
          sign_in_as(other_user)

          click_on '削除'
          expect(accept_confirm).to eq 'サブスクリプション「他のユーザーが登録したサブスク」を削除します。よろしいですか?'
          expect(page).to have_content 'サブスクリプション「他のユーザーが登録したサブスク」を削除しました'
        end
      end
    end
  end

  describe 'check to export correct user subscriptions' do
    it 'export correct user subscriptions to ical' do
      travel_to Time.zone.local(2023, 0o4, 0o1) do
        create(:subscription, user:, name: '継続中のデータ', subscribed: true)
        create(:subscription, user:, name: '停止中のデータ', subscribed: false)
        create(:subscription, user: other_user, name: '別ユーザーのデータ', subscribed: true)
        subscriptions = user.subscriptions.where(subscribed: true)

        cal = Icalendar::Calendar.new
        subscriptions.each do |subscription|
          tzid = 'Asia/Tokyo'

          cal.event do |e|
            e.dtstart     = Icalendar::Values::DateTime.new subscription.calc_next_payment_date, { 'tzid' => tzid }
            e.dtend       = Icalendar::Values::DateTime.new subscription.calc_next_payment_date, { 'tzid' => tzid }
            e.summary     = subscription.name
            e.uid         = "subscription#{subscription.id}"
            e.sequence    = Time.now.to_i
          end
        end
        expect(cal.to_ical).to include('継続中のデータ')
        expect(cal.to_ical).not_to include('停止中のデータ')
        expect(cal.to_ical).not_to include('別ユーザーのデータ')
      end
    end
  end
end
