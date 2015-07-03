class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :pledges, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than: 10}
end
