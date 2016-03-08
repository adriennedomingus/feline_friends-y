class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  belongs_to :address
  has_many :reviews
  accepts_nested_attributes_for :address
  validates :address_id, presence: true

  enum role: %w(default admin)

  def format_address
    "#{address.street}, #{address.city}, #{address.state} #{address.zip} #{address.country}"
  end
end
