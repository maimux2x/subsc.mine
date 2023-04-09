class User < ApplicationRecord
  validates :uid, uniqueness: { scope: :provider }

  def self.find_from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    User.where(provider:, uid:).first
  end
end
