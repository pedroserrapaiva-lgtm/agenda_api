class Users::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    email = params.dig(:user, :email)
    password = params.dig(:user, :password)

    user = User.find_by(email: email)

    if user && user.valid_password?(password)
      token, _payload = Warden::JWTAuth::UserEncoder.new.call(
        user, :user, nil
      )

      sign_in(user)

      render json: {
        status: 200,
        message: "Logged in successfully.",
        data: {
          id: user.id,
          email: user.email,
          name: user.name
        },
        token: token
      }, status: :ok

    else
      puts resource.errors.full_messages
      render json: {
        status: 401,
        message: "Invalid email or password."
      }, status: :unauthorized
    end
  end

  def destroy
    head :no_content
  end
end
