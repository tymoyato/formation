class Contribution < ApplicationRecord
  belongs_to :user
  belongs_to :project
  belongs_to :contrepartie

  validates :amount, :user_id, :project_id, presence: true
end
