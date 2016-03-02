class CatOrder < ActiveRecord::Base
  belongs_to :cat
  belongs_to :order
  validates :order_id, presence: true
  validates :cat_id, presence: true
end
