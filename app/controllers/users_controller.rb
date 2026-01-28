class UsersController < ApplicationController
  before_action :authenticate_user!

  # GET /users/me
  def me
    render json: {
      id: current_user.id,
      email: current_user.email,
      name: current_user.name,
      avatar_url: current_user.avatar_url
    }
  end

  # PATCH /users/avatar
  def update_avatar
    unless params[:avatar].present?
      return render json: { success: false, message: "Nenhuma imagem enviada." }, status: 400
    end

    current_user.avatar.attach(params[:avatar])

    render json: {
      success: true,
      message: "Avatar atualizado!",
      avatar_url: Rails.application.routes.url_helpers.rails_blob_url(
      current_user.avatar,
      host: "http://10.0.2.2:3000"
)
    }
  end
end
