require "rails_helper"

RSpec.feature "visitor can view cats" do

  scenario "visitor can view all cats" do
    create_cats

    visit cats_path
    within(".all_cats") do
      expect(page).to have_content("Chica")
      expect(page).to have_content("Actually a dog")
      expect(page).to have_content("$20.00")
      expect(page).to have_content("Caia")
      expect(page).to have_content("Mena")
      expect(page).to have_content("Penny Lane")
      expect(page).to have_css("img[src=\"#{image_path}\"]")
    end
  end
end
