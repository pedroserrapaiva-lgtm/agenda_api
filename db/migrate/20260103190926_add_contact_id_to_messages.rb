class AddContactIdToMessages < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :contact_id, :integer
  end
end
