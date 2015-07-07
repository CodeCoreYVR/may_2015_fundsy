class Discussion < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable
end
