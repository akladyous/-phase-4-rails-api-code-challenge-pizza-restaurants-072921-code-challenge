class RestaurantPizzasController < ApplicationController


    def create
        @pizza = Pizza.find(params[:pizza_id])
        @restaurant = Restaurant.find(params[:restaurant_id])

        @restaurant_pizza = RestaurantPizza.new(price: params[:price])
        @restaurant_pizza.restaurant = @restaurant
        @restaurant_pizza.pizza = @pizza

        @restaurant_pizza.save
        # @restaurant_pizza.save! # -> trigger rescue_from RecordInvalid

        if @restaurant_pizza.valid?
            render json: @restaurant_pizza, status: :ok
        else
            render json: {error: "validation errors"}
        end
    end
end
