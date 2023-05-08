# frozen_string_literal: true

class User < ApplicationRecord
  after_save :create_id_digest
  validates :uid, uniqueness: { scope: :provider }

  has_many :subscriptions, dependent: :destroy

  def self.from_omniauth(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    User.where(provider:, uid:).first_or_initialize
  end

  def to_param
    id_digest
  end

  private

  def create_id_digest
    return unless id_digest.nil?

    new_digest = Digest::MD5.hexdigest(id.to_s)
    update_column(:id_digest, new_digest)
  end
end
