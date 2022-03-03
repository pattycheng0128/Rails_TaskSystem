require "digest"

class User < ApplicationRecord
  validates :username, presence: true
  validates_uniqueness_of :email
  before_create :encrypt_password
  has_many :tasks

  def self.login(user_info)
    email = user_info[:email]
    password = user_info[:password]

    salted_password = "hi#{password.reverse}"
    encryted_password = Digest::SHA1.hexdigest(salted_password)

    self.find_by(email: email, password: encryted_password)
  end

  private
  def encrypt_password
    salted_password = "hi#{self.password.reverse}"
    self.password = Digest::SHA1.hexdigest(salted_password)
  end

end
