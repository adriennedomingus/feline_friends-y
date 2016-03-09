* **Project Overview**  

  Feline Friends-y is an e-commerce site designed as the final project for Module 2 at the Turing School of Software and Design. The [Project Spec](https://github.com/turingschool/curriculum/blob/master/source/projects/little_shop.markdown) can be found here.

  It is deployed on Heroku, and can be found in production [here](https://felinefriendsy.herokuapp.com).

**Team**
  * [Adrienne Domingus](github.com/adriennedomingus)
  * [Allan Blair](github.com/amaxwellblair)
  * [Chelsea Johnson](github.com/cheljoh)

**Local Setup**

  1. Clone the repository `git clone git@github.com:adriennedomingus/feline_friends-y.git`
  2. `cd` into the app directory
  3. Run `rake db:create db:migrate db:seed` If you would like to create your own cats and users, skip this step.
  4. To run the application in the development environment, run `rails s`

**Test suite**

The test suite is built using RSpec and tests both models and features. Feature tests are written using Capybara to mimic the user experience. To run the entire test suite, from the command line in the root of the app directory, run:
```
rspec
```
