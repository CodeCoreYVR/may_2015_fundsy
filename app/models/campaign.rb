class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :pledges, dependent: :destroy
  has_many :reward_levels, dependent: :destroy

  # we need to add as: :commentable because comments has a belongs to
  # in a ploymorphic association fashion
  has_many :comments, dependent: :destroy, as: :commentable

  accepts_nested_attributes_for :reward_levels, allow_destroy: true,
    reject_if: lambda {|x| x[:amount].empty? &&
                           x[:title].empty?  &&
                           x[:description].empty? }

  # this makes sure the campaign is created with at least one reward level
  validates :reward_levels, presence: true

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :goal, presence: true, numericality: {greater_than: 10}
end
