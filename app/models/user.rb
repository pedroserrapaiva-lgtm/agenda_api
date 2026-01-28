class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  has_many :messages, dependent: :destroy
  has_many :contacts, dependent: :destroy

  has_one_attached :avatar

  def avatar_url
  return nil unless avatar.attached?

  Rails.application.routes.url_helpers.rails_blob_url(
    avatar,
    host: "http://10.0.2.2:3000"
  )
end
end
