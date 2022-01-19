require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  before do
    r1 = Restaurant.create(name: "Sottocasa NYC", address: "298 Atlantic Ave, Brooklyn, NY 11201")
    r2 = Restaurant.create(name: "PizzArte", address: "69 W 55th St, New York, NY 10019")
    p1 = Pizza.create(name: "Cheese", ingredients: "Dough, Tomato Sauce, Cheese")
    p2 = Pizza.create(name: "Pepperoni", ingredients: "Dough, Tomato Sauce, Cheese, Pepperoni")
    RestaurantPizza.create(pizza_id: p1.id, restaurant_id: r1.id, price: 10)
    RestaurantPizza.create(pizza_id: p2.id, restaurant_id: r1.id, price: 12)
    RestaurantPizza.create(pizza_id: p2.id, restaurant_id: r2.id, price: 12)
  end

  describe "GET /restaurants" do
    it 'returns an array of all restaurants' do
      get '/restaurants'

      expect(response.body).to include_json([
        {
          id: a_kind_of(Integer),
          name: "Sottocasa NYC",
          address: "298 Atlantic Ave, Brooklyn, NY 11201"
        },
        {
          id: a_kind_of(Integer),
          name: "PizzArte",
          address: "69 W 55th St, New York, NY 10019"
        }
      ])
    end

    it 'does not return any nested pizzas' do
      get '/restaurants'

      expect(response.body).not_to include_json([
        {
          pizzas: a_kind_of(Array)
        }
      ])
    end

    it 'returns a status of 200 (OK)' do
      get '/restaurants'
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /restaurants/:id" do
    
    context "with a valid ID" do

      it "returns the matching restaurant with its associated pizzas" do
        get "/restaurants/#{Restaurant.first.id}"
        expect(response.body).to include_json({
          id: a_kind_of(Integer),
          name: "Sottocasa NYC",
          address: "298 Atlantic Ave, Brooklyn, NY 11201",
          pizzas: [
            {
              id: a_kind_of(Integer),
              name: "Cheese", 
              ingredients: "Dough, Tomato Sauce, Cheese"
            },
            {
              id: a_kind_of(Integer),
              name: "Pepperoni", 
              ingredients: "Dough, Tomato Sauce, Cheese, Pepperoni"
            }
          ]
        })
      end

      it 'returns a status of 200 (OK)' do
        get "/restaurants/#{Restaurant.first.id}"
        expect(response).to have_http_status(:ok)
      end
      
    end

    context "with an invalid ID" do
      
      it "returns an error message" do
        get "/restaurants/bad_id"
        expect(response.body).to include_json({
          error: "Restaurant not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        get "/restaurants/bad_id"
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  describe "DELETE /restaurants/:id" do

    context "with a valid ID" do

      it "deletes the Restaurant" do
        expect { delete "/restaurants/#{Restaurant.first.id}" }.to change(Restaurant, :count).by(-1)
      end

      it "deletes the associated RestaurantPizzas" do
        expect { delete "/restaurants/#{Restaurant.first.id}" }.to change(RestaurantPizza, :count).by(-2)
      end

    end

    context "with an invalid ID" do
      
      it "returns an error message" do
        delete "/restaurants/bad_id"
        expect(response.body).to include_json({
          error: "Restaurant not found"
        })
      end
      
      it "returns the appropriate HTTP status code" do
        delete "/restaurants/bad_id"
        expect(response).to have_http_status(:not_found)
      end

    end

  end
end
