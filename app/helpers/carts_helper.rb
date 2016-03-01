module CartsHelper
  def path(cat)
    "<a href=\"/cats/#{cat.id}\">#{cat.name}</a>"
  end
end
