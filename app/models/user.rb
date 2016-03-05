class User < ActiveRecord::Base
  has_secure_password

  has_many :orders
  belongs_to :address

  enum role: %w(default admin)

  def format_address
    "#{address.street}, #{address.city}, #{address.state} #{address.zip} #{address.country}"
  end


end
