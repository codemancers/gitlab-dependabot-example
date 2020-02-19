# frozen_string_literal: true

class User < ApplicationRecord
  validates_presence_of :provider, :gid, :email, :fullname, :handle, :picture, :access_token

  def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, gid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.gid = auth.uid
      user.bio = auth.extra.raw_info.bio
      user.email = auth.info.email
      user.fullname = auth.info.name
      user.handle = auth.info.username
      user.picture = auth.info.image
      user.access_token = auth.credentials.token

      user.save!
    end
  end
end
