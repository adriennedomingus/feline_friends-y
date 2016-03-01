module SpecHelpers
  def create_cats
    path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"
    [
      Cat.create(
        name: "Fido",
        age: 2,
        description: "Actually a dog",
        image: path,
        price: 2000),
      Cat.create(
        name: "Caia",
        age: 8,
        description: "Chelsea's other cat",
        image: path,
        price: 3000),
      Cat.create(
        name: "Mena",
        age: 4,
        description: "Adrienne's cat",
        image: path,
        price: 4000),
      Cat.create(
        name: "Penny Lane",
        age: 13,
        description: "Chelsea's other cat",
        image: path,
        price: 4000)
    ]
  end

  def create_categories
    [Category.create(name: "Fluffy"),
     Category.create(name: "Friendly"),
     Category.create(name: "Happy")]
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.include SpecHelpers
end
