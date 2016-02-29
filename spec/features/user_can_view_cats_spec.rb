require "rails_helper"

RSpec.feature "visitor can view cats" do

  scenario "visitor can view all cats" do
    Cat.create(name: "Fido", age: 2)
    Cat.create(name: "Caia", age: 8)
    Cat.create(name: "Mena", age: 4)
    Cat.create(name: "Penny Lane", age: 13)

    visit cats_path

    within(".all_cats") do
      expect(page).to have_content("Fido")
      expect(page).to have_content("Caia")
      expect(page).to have_content("Mena")
      expect(page).to have_content("Penny Lane")
    end
  end
end
