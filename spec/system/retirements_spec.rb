# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Retirements', type: :system do
  let(:user) { create(:user) }

  describe 'User' do
    context 'user is login', js: true do
      it 'user can retirements' do
        sign_in_as user
        visit new_retirements_path

        click_on 'アカウントを削除する'
        expect(page).to have_content '退会が完了しました。'
        expect(User.count).to eq 0
        expect(current_path).to eq root_path
        expect(page).to have_content '次のお支払日いつだっけ'
      end
    end
  end
end
