class User < ActiveRecord::Base
  after_create :send_welcome_email
  devise :database_authenticatable, :recoverable, :validatable
  attr_accessible :email, :password, :password_confirmation, :display_name
  has_many :posts
  DISPLAY_NAME_REGEX = /^[\w-]*$/
  validates :display_name, format: { with: DISPLAY_NAME_REGEX, message: "must be only letters, numbers, dashes, or underscores" }, presence: true
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end
end
