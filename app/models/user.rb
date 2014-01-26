class User < ActiveRecord::Base
  # attr_accessible :email, :name, :oauth_expires_at, :oauth_token, :provider, :uid

  has_many :reminders

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end

  def self.from_android(provider, token) 
    fbuser = FbGraph::User.me(token).fetch
    user.provider = provider
    user.uid = fbuser.user_id
    user.name = fbuser.name
    user.email = fbuser.email
    user.oauth_token = token
    user.oauth_expires_at = 1.week.from_now
    user.save!
  end
end
