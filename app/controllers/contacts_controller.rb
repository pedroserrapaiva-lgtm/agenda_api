class ContactsController < ApplicationController
  before_action :authenticate_user!

  def index
    contacts = current_user.contacts.order(created_at: :desc)
    render json: contacts, status: :ok
  end

  def create
    contact = current_user.contacts.new(contact_params)

    if contact.save
      render json: contact, status: :created
    else
      render json: { errors: contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
  contact = Contact.find_by(id: params[:id])

  if contact.nil?
    render json: { error: "Contato não encontrado" }, status: :not_found
    return
  end

  contact.destroy
  head :no_content
end
  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email)
  end
end
