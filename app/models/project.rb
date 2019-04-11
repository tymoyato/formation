class Project < ApplicationRecord
  belongs_to :category
  include ImageUploader::Attachment.new(:landscape)
  include ImageUploader::Attachment.new(:thumb)
end
