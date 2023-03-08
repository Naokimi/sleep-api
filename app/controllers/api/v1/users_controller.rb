module Api
  module V1
    class UsersController < Api::V1::BaseController
      def create
        user = User.new(user_params)
        if user.save
          render json: { user: user }, status: :created
        else
          render json: { error: user.errors.messages }, status: :bad_request
        end
      end

      def destroy
        User.find(params[:id])&.destroy!
        render json: { message: "User #{params[:id]} successfully deleted" }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name)
      end
    end
  end
end
