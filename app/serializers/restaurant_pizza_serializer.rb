class RestaurantPizzaSerializer < ActiveModel::Serializer
    attributes :price

    has_one :pizza
    # has_one :restaurant
end
