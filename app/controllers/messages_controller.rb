class MessagesController < ApplicationController
  before_action :authenticate_user!

  # GET /messages
  def index
    @messages = current_user.messages
    render json: @messages
  end

  # POST /messages
  def create
    @message = current_user.messages.build(message_params)

    if @message.save
      render json: @message, status: :created
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH /messages/:id
  def update
    @message = current_user.messages.find(params[:id])

    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /messages/:id
  def destroy
    @message = current_user.messages.find(params[:id])
    @message.destroy
    head :no_content
  end

  private

  def message_params
    params.require(:message).permit(:title, :body)
  end
end
