require 'rails_helper'

RSpec.describe "Welcome", type: :system do
  let(:user) { FactoryBot.create(:user) }

  it 'ユーザがログインできる' do
    sign_in_as(user)
    expect(page).to have_content 'ログインしました'
  end
end
