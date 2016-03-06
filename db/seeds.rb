# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: "fluffy")
Category.create(name: "mean")
Category.create(name: "friendly")
Address.create(state: "CA",
                          city: "San Francisco",
                          street: "4325 W. Palm Beach Rd.",
                          zip: "94116",
                          country: "United States")
User.create(name: "admin", username: "admin", password: "password", address_id: Address.first.id, role: 1)

Cat.create(
  name: "Chica",
  age: 2,
  description: "Actually a dog",
  image: "http://data.whicdn.com/images/54126468/large.gif",
  price: 2000,
  category_id: Category.first.id,
  status: "inactive")
 Cat.create(
  name: "Caia",
  age: 8,
  description: "Chelsea's other cat",
  image: "http://data.whicdn.com/images/54126468/large.gif",
  price: 3000,
  category_id: Category.first.id,
  status: "active")
 Cat.create(
  name: "Mena",
  age: 4,
  description: "Adrienne's cat",
  image: "http://data.whicdn.com/images/54126468/large.gif",
  category_id: Category.first.id,
  price: 4000)
Cat.create(
  name: "Penny Lane",
  age: 13,
  description: "Chelsea's other cat",
  image: "http://data.whicdn.com/images/54126468/large.gif",
  category_id: Category.first.id,
  price: 4000)
