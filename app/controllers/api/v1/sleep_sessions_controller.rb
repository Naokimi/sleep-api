module Api
  module V1
    class SleepSessionsController < Api::V1::BaseController
      before_action :set_user
      before_action :set_active_sleep_session, only: %i[clock_in clock_out]

      def clock_in
        return render_error("There is already an active sleep session for user #{@user.id}") if @sleep_session

        sleep_session = SleepSession.create(user: @user)
        render json: { sleep_session: sleep_session }, status: :created
      end

      def clock_out
        return render_error("There is no active sleep session for user #{@user.id}") unless @sleep_session

        ended_at = Time.now
        @sleep_session.update(ended_at: ended_at, length: ended_at - @sleep_session.created_at)
        render json: { sleep_session: @sleep_session }, status: :ok
      end

      def index
        sleep_sessions = @user.sleep_sessions.order(created_at: :desc)
        render json: { sleep_sessions: sleep_sessions }, status: :ok
      end

      def friends
        sleep_sessions = SleepSession.where(user_id: @user.followed_user_ids, created_at: 1.week.ago..Time.now)
                                     .where.not(length: nil)
                                     .order(length: :desc)
        render json: { sleep_sessions: sleep_sessions }, status: :ok
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def set_active_sleep_session
        @sleep_session = @user.sleep_sessions.find_by(ended_at: nil)
      end
    end
  end
end
