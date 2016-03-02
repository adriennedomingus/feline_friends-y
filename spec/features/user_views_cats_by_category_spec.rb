require "rails_helper"

RSpec.feature "user can view cats by category" do
  scenario "user views cats in a specific category" do
    category1 = categories[0]

    cat1 = create_cats[:cat1]
    cat2 = create_cats[:cat2]

    category1.cats << cat1
    category1.cats << cat2

    visit category_path(category1.name)

    expect(page).to have_content(cat1.name)
    expect(page).to have_content(cat2.name)
  end
end
