class RewardLevel < ActiveRecord::Base
  belongs_to :campaign, touch: true

  validates :title, presence: true
  validates :description, presence: true
  validates :amount, presence: true, numericality: {greater_than: 0}
end
