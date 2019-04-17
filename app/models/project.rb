class Project < ApplicationRecord
  belongs_to :category
  has_many :contributions, dependent: :destroy
  has_many :users, through: :contributions
  validates :name, :amount, presence: true
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumb)
end
