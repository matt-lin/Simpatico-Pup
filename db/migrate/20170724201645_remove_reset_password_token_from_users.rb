class RemoveResetPasswordTokenFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :reset_password_token, :string
    remove_column :users, :string, :string
  end
end
