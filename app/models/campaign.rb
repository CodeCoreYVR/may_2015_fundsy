class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :pledges, dependent: :destroy
  has_many :reward_levels, dependent: :destroy

  accepts_nested_attributes_for :reward_levels,
    reject_if: lambda {|x| x[:amount].empty? &&
                           x[:title].empty?  &&
                           x[:description].empty? }

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than: 10}
end
