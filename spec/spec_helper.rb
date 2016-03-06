module SpecHelpers
  def create_integration
    user = create_users[:user1]
    order = create_orders[:order1]
    cat = Cat.create(
      name: "Chica",
      age: 2,
      description: "Actually a dog",
      image: image_path,
      price: 2000,
      category_id: categories[0].id,
      status: "inactive")
    cat2 = Cat.create(
      name: "Caia",
      age: 8,
      description: "Chelsea's other cat",
      image: image_path,
      price: 3000,
      category_id: categories[0].id,
      status: "active")
    CatOrder.create(order_id: order.id, cat_id: cat.id)
    CatOrder.create(order_id: order.id, cat_id: cat2.id)
    user.orders << order

    [user, order, cat, cat2]
  end

  def create_orders
    {
      order1: Order.create(status: 1,
                           cancelled_at: "2016-03-02 11:10:57 -0700"),
      order2: Order.create(status: 0),
      order3: Order.create(status: 0),
    }
  end

  def create_address
    Address.find_or_create_by(state: "CA",
                              city: "San Francisco",
                              street: "4325 W. Palm Beach Rd.",
                              zip: "94116",
                              country: "United States")
  end

  def create_users
    address = create_address
    {
      user1: User.create(username: "adrienne",
                         password: "password",
                         name: "Adrienne",
                         address_id: address.id),
      user2: User.create(username: "chelsea",
                         password: "password",
                         name: "Chelsea",
                         address_id: address.id),
      user3: User.create(username: "allan",
                         password: "stinky",
                         name: "Allan",
                         address_id: address.id)
    }
  end

  def create_user_orders
    user1  = create_users[:user1]
    user2  = create_users[:user2]
    user3  = create_users[:user3]
    order1 = user1.orders.create(status: 0)
    order2 = user1.orders.create(status: 1)
    order3 = user2.orders.create(status: 2)
    order4 = user3.orders.create(status: 2)
    [order1, order2, order3, order4]
  end

  def log_in_user(user)
    fill_in "Username", with: user.username
    fill_in "Password", with: "password"

    click_on "Login Meow!"
  end

  def create_admin
    User.create(username: "adrienne",
                password: "password",
                name: "bacon",
                role: 1,
                address_id: create_address.id)
  end

  def create_cat
    Cat.create(
      name: "Fido",
      age: 2,
      description: "Actually a dog",
      image: image_path,
      price: 2000,
      category_id: categories[0].id,
      status: "active")
  end

  def image_path
    "http://data.whicdn.com/images/54126468/large.gif"
  end

  def create_cats
    {
      cat1: Cat.create(
        name: "Chica",
        age: 2,
        description: "Actually a dog",
        image: image_path,
        price: 2000,
        category_id: categories[0].id,
        status: "inactive"),
      cat2: Cat.create(
        name: "Caia",
        age: 8,
        description: "Chelsea's other cat",
        image: image_path,
        price: 3000,
        category_id: categories[0].id,
        status: "active"),
      cat3: Cat.create(
        name: "Mena",
        age: 4,
        description: "Adrienne's cat",
        image: image_path,
        category_id: categories[1].id,
        price: 4000),
      cat4: Cat.create(
        name: "Penny Lane",
        age: 13,
        description: "Chelsea's other cat",
        image: image_path,
        category_id: categories[2].id,
        price: 4000)
    }
  end

  def categories
    [Category.find_or_create_by(name: "Fluffy"),
     Category.find_or_create_by(name: "Friendly"),
     Category.find_or_create_by(name: "Happy")]
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
