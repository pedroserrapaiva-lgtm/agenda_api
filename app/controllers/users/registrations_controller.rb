class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  
  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      sign_in(resource)

      token = current_token

      render json: {
        status: { code: 201, message: "Usuário criado com sucesso." },
        token: token,
        data: resource
      }, status: :created
    else
      render json: {
        status: { code: 422, message: "Usuário não pôde ser criado." },
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def current_token
    request.env['warden-jwt_auth.token']
  end
end
