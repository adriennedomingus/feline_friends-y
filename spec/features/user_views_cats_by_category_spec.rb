require "rails_helper"

RSpec.feature "user can view cats by category" do
  scenario "user views cats in a specific category" do
    c1 = Category.create(name: "Fluffy")
    c2 = Category.create(name: "Friendly")
    path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"

    cat1 = Cat.create(
      name: "Fido",
      age: 2,
      description: "Actually a dog",
      image: path,
      price: 2000,
      category_id: c2.id)
    Cat.create(
      name: "Caia",
      age: 8,
      description: "Chelsea's other cat",
      image: path,
      price: 3000,
      category_id: c1.id)
    cat3 = Cat.create(
      name: "Mena",
      age: 4,
      description: "Adrienne's cat",
      image: path,
      price: 4000,
      category_id: c2.id)

    visit category_path(c2.name)

    expect(page).to have_content(cat1.name)
    expect(page).to have_content(cat3.name)
  end
end
