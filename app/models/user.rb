class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  validates :first_name, :last_name, :date_of_birth, presence: true
  validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
end
