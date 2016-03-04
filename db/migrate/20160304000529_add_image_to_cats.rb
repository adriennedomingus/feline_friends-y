class AddImageToCats < ActiveRecord::Migration
  def change
    add_column :cats, :image, :string, default: "https://s-media-cache-ak0.pinimg.com/originals/96/cb/f1/96cbf1cb56de8d012513832d664d0902.gif"
  end
end
