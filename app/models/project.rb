class Project < ApplicationRecord
  belongs_to :category

  validates :name, :amount, presence: true
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumb)
end
