module Api
  module V1
    class RelationshipsController < Api::V1::BaseController
      def follow
        Relationship.create!(follower_id: params[:follower_id], followed_id: params[:user_id])
        render json: { message: "User #{params[:follower_id]} now follows user #{params[:user_id]}" }, status: :created
      end

      def unfollow
        relationship = Relationship.find_by(follower_id: params[:follower_id], followed_id: params[:user_id])
        return render_error("User #{params[:follower_id]} doesn't follow user #{params[:user_id]}", :not_found) if relationship.nil?

        relationship.destroy!
        render json: { message: "User #{params[:follower_id]} stopped following user #{params[:user_id]}" }, status: :ok
      end
    end
  end
end
