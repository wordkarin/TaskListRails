class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, presence: true
  validates :user, presence: true
end
