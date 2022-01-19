require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  describe "relationships" do
      
    let(:restaurant) { Restaurant.create(name: "Sottocasa NYC", address: "298 Atlantic Ave, Brooklyn, NY 11201") }
    let(:pizza) { Pizza.create(name: "Cheese", ingredients: "Dough, Tomato Sauce, Cheese") }

    it 'can access the associated restaurant_pizzas' do
      restaurant_pizza = RestaurantPizza.create(pizza_id: pizza.id, restaurant_id: restaurant.id, price: 10)

      expect(restaurant.restaurant_pizzas).to include(restaurant_pizza)
    end

    it 'can access the associated pizza' do
      RestaurantPizza.create(pizza_id: pizza.id, restaurant_id: restaurant.id, price: 10)

      expect(restaurant.pizzas).to include(pizza)
    end
  
  end

end
