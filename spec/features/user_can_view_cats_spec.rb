require "rails_helper"

RSpec.feature "visitor can view cats" do

  scenario "visitor can view all cats" do
    path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"
    Cat.create(
      name: "Fido",
      age: 2,
      description: "Actually a dog",
      image: path,
      price: 2000)
    Cat.create(
      name: "Caia",
      age: 8,
      description: "Chelsea's other cat",
      image: path,
      price: 3000)
    Cat.create(
      name: "Mena",
      age: 4,
      description: "Adrienne's cat",
      image: path,
      price: 4000)
    Cat.create(
      name: "Penny Lane",
      age: 13,
      description: "Chelsea's other cat",
      image: path,
      price: 4000)
    visit cats_path
    within(".all_cats") do
      expect(page).to have_content("Fido")
      expect(page).to have_content("Actually a dog")
      expect(page).to have_content("$20.00")
      expect(page).to have_content("Caia")
      expect(page).to have_content("Mena")
      expect(page).to have_content("Penny Lane")
      expect(page).to have_css("img[src=\"#{path}\"]")
    end
  end
end
