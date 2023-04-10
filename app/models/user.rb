# frozen_string_literal: true

class User < ApplicationRecord
  validates :uid, uniqueness: { scope: :provider }

  def self.from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    User.where(provider:, uid:).first_or_initialize
  end
end
