class Contrepartie < ApplicationRecord
has_many :contributions, dependent: :destroy
end
