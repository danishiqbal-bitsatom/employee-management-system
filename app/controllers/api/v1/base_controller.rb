module Api
  module V1
    class BaseController < ApplicationController

      skip_before_action :authenticate_user!

      protect_from_forgery with: :null_session

    end


     private

      def authorize_request

        header = request.headers["Authorization"]

        token = header.split(" ").last if header

        begin
          decoded = JsonWebToken.decode(token)

          @current_user = User.find(decoded[:user_id])

        rescue
          render json: {
            error: "Unauthorized"
          }, status: :unauthorized
        end
      end
  end
end