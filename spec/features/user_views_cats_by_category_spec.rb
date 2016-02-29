require "rails_helper"

RSpec.feature "user can view cats by category" do
  scenario "user views cats in a specific category" do
    c1 = Category.create(name: "Fluffy")
    c2 = Category.create(name: "Friendly")

    cat1 = Cat.create(name: "Caia", age: "2", category_id: c2.id )
    cat2 = Cat.create(name: "Mena", age: "4", category_id: c1.id )
    cat3 = Cat.create(name: "Penny Lane", age: "4", category_id: c2.id )

    visit cats_path

    select "Friendly", from: "cat[category_id]"
    click_on "Go"

    within(".all_cats") do
      expect(page).to have_content(cat1.name)
      expect(page).to have_content(cat3.name)
    end
  end
end
