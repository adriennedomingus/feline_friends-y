class CatOrder < ActiveRecord::Base
  belongs_to :cat
  belongs_to :order
  validates :cat_id, presence: true
end
