class Task < ActiveRecord::Base
  belongs_to :user

  validates :title, :description, presence: true
  validates :user, presence: true
end

# QUESTION: the Task model should include at least a name, a description and a completion indicator - in the db schema?
# create a Task model and migration.
