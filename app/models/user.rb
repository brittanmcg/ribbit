require "digest/md5"

class User < ActiveRecord::Base
  has_secure_password

  before_validation :prep_email
  before_save :create_avatar_url

  validates :email, presence: true, uniqueness: true, format: { with: /[\w\.+-]+@([\w]+\.)+[a-zA-Z]+/ }
  validates :username, presence: true, uniqueness: true
  validates :name, presence: true

  private

  def prep_email
    self.email = self.email.strip.downcase if self.email
  end

  def create_avatar_url
    self.avatar_url = "http://www.gravatar.com/avatar/#{Digest::MD5.hexidigest(self.email)}?s=50"
  end
end
