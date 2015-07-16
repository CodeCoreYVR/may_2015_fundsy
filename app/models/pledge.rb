class Pledge < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :campaign

  validates :amount, presence: true, numericality: {greater_than: 0}

  aasm whiny_transitions: false do
    state :pending, initial: true
    state :completed
    state :cancelled
    state :refunded

    event :complete do
      transitions from: :pending, to: :completed
    end

    event :cancel do
      transitions from: [:pending, :completed], to: :cancelled
    end

    event :refund do
      transitions from: :completed, to: :refunded
    end
  end


end
