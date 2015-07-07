class User < ActiveRecord::Base
  has_many :campaigns, dependent: :destroy
  has_many :comments

  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :password, presence: true

  def full_name
    "#{first_name} #{last_name}".strip
  end

end
