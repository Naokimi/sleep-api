module Api
  module V1
    class BaseController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from StandardError, with: :render_error

      private

      def render_error(error, status = :bad_request)
        render json: { error: error }, status: status
      end

      def not_found(exception)
        render json: { error: exception.message }, status: :not_found
      end
    end
  end
end
