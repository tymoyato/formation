class Contrepartie < ApplicationRecord
  belongs_to :project
  has_many :contributions, dependent: :destroy
  validates :project_id, :name, :amount, :stock_state, presence: true
end
