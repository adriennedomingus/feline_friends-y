class Address < ActiveRecord::Base
  has_many :users
  validates :country, presence: true
  validates :state, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :zip, presence: true
end
