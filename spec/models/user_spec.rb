require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.find_or_create_from_auth_hash!' do
    it 'success login' do
      user = create(:user)
      auth_hash = { provider: user.provider, uid: user.uid }
      expect(User.from_omniauth(auth_hash)).to eq user
    end

    it 'failure login' do
      user = build(:user)
      auth_hash = { provider: 'google', uid: nil }
      expect(User.from_omniauth(auth_hash)).not_to eq user
    end
  end
end