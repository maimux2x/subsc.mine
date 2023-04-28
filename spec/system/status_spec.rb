# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Status', type: :system do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  describe 'subscription edit screen' do
    let!(:users_subscription) { create(:subscription, name: '継続から停止に変更するサブスク', subscribed: true, user:) }
    let!(:other_users_subscription) { create(:subscription, name: '停止から継続に変更するサブスク', subscribed: false, user: other_user) }

    context 'change status ongoing to standstill' do
      it 'user can edit subscription', js: true do
        sign_in_as(user)

        click_on 'ステータス変更'
        select '停止中', from: 'ステータス'
        click_button '更新する'

        expect(page).to have_selector '.notification', text: 'サブスクリプション「継続から停止に変更するサブスク」を編集しました。'
        expect(page).to have_content '停止中'
      end
    end

    context 'change status standstil to ongoing' do
      it 'user can edit subscription', js: true do
        sign_in_as(other_user)

        click_on 'ステータス変更'
        select '継続中', from: 'ステータス'
        fill_in 'お支払日', with: DateTime.new(2023, 4, 1, 10, 30)
        click_button '更新する'

        expect(page).to have_selector '.notification', text: 'サブスクリプション「停止から継続に変更するサブスク」を編集しました。'
        expect(page).to have_content '継続中'
      end
    end
  end
end
