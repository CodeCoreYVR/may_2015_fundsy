class User < ActiveRecord::Base
  has_many :campaigns, dependent: :destroy
  has_many :comments

  has_secure_password

  before_create :generate_api_key

  # geocoded_by / geocode methods come from the Geocoder gem
  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true,
            format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, unless: :from_oauth?
  validates :password, presence: true, unless: :from_oauth?

  def from_oauth?
    uid.present? && provider.present?
  end

  def can_publish_to_twitter?
    uid.present? && provider.present? && provider == "twitter"
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  private

  def generate_api_key
    begin
      self.api_key = SecureRandom.hex
    end while User.exists?(api_key: self.api_key)
  end

end
