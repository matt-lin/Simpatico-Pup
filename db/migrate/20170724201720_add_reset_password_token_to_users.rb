class AddResetPasswordTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reset_password_token, :string
    add_column :users, :string, :string
  end
end
