class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  validates :email, presence: true, uniqueness: true, length: {in: 1..100}, format: { with: /\A([a-zA-Z0-9_.+-]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: {in: 6..50}, allow_nil: true
  validates_confirmation_of :password
end
