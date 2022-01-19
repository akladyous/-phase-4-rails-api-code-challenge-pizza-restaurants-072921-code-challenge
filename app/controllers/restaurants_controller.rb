class RestaurantsController < ApplicationController

    def index
        render json: Restaurant.all, status: :ok
    end

    def show
        @restaurant = load_restaurant
        if @restaurant
            render json: @restaurant, serializer: RestaurantWithPizzasSerializer, status: :ok
        else
            render json: {error: "Restaurant not found"}, status: :not_found
        end
    end

    def destroy
        @restaurant = Restaurant.find_by(params[:id])
        # byebug
        if @restaurant
            @restaurant.destroy
            render json: {}, status: :ok
        else
            render json: {error: "Restaurant not found"}, status: :not_found
        end
    end

    private

    def load_restaurant
        Restaurant.find_by(id: params[:id])
    end
    def restaurant_params
        params.permit(:name, :address)
    end
end
