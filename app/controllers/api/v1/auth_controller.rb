module Api
  module V1
    class AuthController < BaseController

      def login

  #         render json: {
  #   message: "Auth Controller Working"
  # }

        user = User.find_by(
          email: params[:email]
        )

        if user&.valid_password?(params[:password])

          token = JsonWebToken.encode(
            user_id: user.id
          )

          render json: {
            token: token,
            user_id: user.id,
            email: user.email
          }, status: :ok

        else

          render json: {
            error: "Invalid email or password"
          }, status: :unauthorized

        end

      end

    end
  end
end