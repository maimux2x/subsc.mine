# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Welcome", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it 'user can login' do
    sign_in_as(user)
    expect(page).to have_content 'ログインしました'
  end

  it 'user can logout' do
    sign_in_as(user)
    find('.nav-link').hover
    click_on 'ログアウト'

    expect(page).to have_content 'ログアウトしました'
    expect(page).to have_content '次のお支払日いつだっけ'
  end

  it 'unauthenticated user is redirected to the top page' do
    visit subscriptions_path

    expect(page).to have_content '次のお支払日いつだっけ'
  end

  it 'authenticated user can access sabuscriptions page' do
    sign_in_as user
    visit subscriptions_path

    expect(page).to have_content 'Subsc.mineでサブスクリプションの管理をしよう！'
  end
end
