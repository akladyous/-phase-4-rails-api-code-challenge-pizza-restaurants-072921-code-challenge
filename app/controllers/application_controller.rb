class ApplicationController < ActionController::API
  include ActionController::Cookies

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    # rescue_from ActiveRecord::RecordInvalid, with: :invalid_record


    private

    def record_not_found exception
        render json: {error: exception.message}, status: :not_found
    end

    def invalid_record exception
        render json: {error: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
end
