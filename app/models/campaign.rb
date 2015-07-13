class Campaign < ActiveRecord::Base
  belongs_to :user
  has_many :pledges, dependent: :destroy
  has_many :reward_levels, dependent: :destroy

  scope :published, lambda { where(aasm_state: :published) }

  # geocoded_by / geocode methods come from the Geocoder gem
  geocoded_by :address
  after_validation :geocode          # auto-fetch coordinates

  include AASM

  # AASM will use aasm_state database field by default to store the state
  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :cancelled
    state :failed
    state :goal_attained

    # event is a method from AASM takes an arguement (event name)
    # and a block of code
    event :publish do
      transitions({from: :draft, to: :published})
    end

    event :cancel do
      transitions from: [:published, :draft], to: :cancelled
    end

    event :restore do
      transitions from: :cancelled, to: :draft
    end

    event :win do
      transitions from: :published, to: :goal_attained
    end

    event :lose do
      transitions from: :published, to: :failed
    end

    event :recycle do
        transitions from: :failed, to: :draft
    end
  end

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
