class RestaurantWithPizzasSerializer < ActiveModel::Serializer
    attributes :id, :name, :address
    # config.key_format = :lower_camel

    has_many :pizzas, each_serializer: RestaurantWithPizzasSerializer
    # has_many :pizzas, serializer: RestaurantWithPizzasSerializer

    # def filter(keys)
    #     byebug
    #     keys.delete :puzzas unless scope.id?
    #     keys
    # end
    # def pizzas
    #     # byebug
    #     object.pizzas unless object.id.present?
    # end
end
