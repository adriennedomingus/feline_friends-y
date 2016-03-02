module SpecHelpers
  def create_integration
    user = create_users[0]
    order = create_orders[0]
    category = create_categories[0]
    cat = create_cats[0]
    cat2 = create_cats[1]
    cat.update(category_id: category.id)
    cat2.update(category_id: category.id)
    CatOrder.create(order_id: order.id, cat_id: cat.id)
    CatOrder.create(order_id: order.id, cat_id: cat2.id)
    user.orders << order

    [user, order, cat, cat2]
  end

  def create_orders
    [
      Order.create(status: 1),
      Order.create(status: 0),
      Order.create(status: 0),
    ]
  end

  def create_users
    [
      User.create(username: "adrienne",
                  password: "password",
                  name: "Adrienne"),
      User.create(username: "chelsea",
                  password: "password",
                  name: "Chelsea")
    ]
  end

  def create_cats
    path = "http://www.altpress.com/images/uploads/news/Hello_Kißtty.jpg"
    [
      Cat.create(
        name: "Fido",
        age: 2,
        description: "Actually a dog",
        image: path,
        price: 2000,
        status: "inactive"),
      Cat.create(
        name: "Caia",
        age: 8,
        description: "Chelsea's other cat",
        image: path,
        price: 3000,
        status: "active"),
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
