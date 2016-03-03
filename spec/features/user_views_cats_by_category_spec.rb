require "rails_helper"

RSpec.feature "user can view cats by category" do
  scenario "user views cats in a specific category" do
    category1 = categories[0]

    cat1 = create_cats[:cat1]
    cat2 = create_cats[:cat2]

    visit category_path(category1.name)

    expect(page).to have_content(cat1.name)
    expect(page).to have_content(cat2.name)
  end
  scenario "user views cats in multiple categories" do
    category1 = categories[0]
    category2 = categories[1]
    category3 = categories[2]

    cat1 = create_cats[:cat1]
    cat2 = create_cats[:cat3]
    cat3 = create_cats[:cat4]

    visit category_path(category1.name)

    within(".all_cats") do
      expect(page).to have_content(cat1.name)
    end

    visit category_path(category2.name)

    within(".all_cats") do
      expect(page).to have_content(cat2.name)
    end

    visit category_path(category3.name)

    within(".all_cats") do
      expect(page).to have_content(cat3.name)
    end
  end
  scenario "user views category with no associated cats" do
    category = Category.create(name: "silly")
    cat = create_cats[:cat1]

    visit category_path(category.name)

    within(".all_cats") do
      expect(page).to_not have_content(cat.name)
    end
  end
end
