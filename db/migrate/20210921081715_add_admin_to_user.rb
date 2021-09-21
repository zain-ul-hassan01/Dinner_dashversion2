class AddAdminToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :full_name, :string, null: false, default: ' '
    add_column :users, :display_name, :string, null: true
  end
end
