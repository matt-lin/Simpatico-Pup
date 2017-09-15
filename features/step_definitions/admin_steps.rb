#Iter 4-1 provide step definition for admin feature (By Gung Hiu Ho, Licong Wang)
Given (/^the following admin exist:$/) do |admins_table|
  admins_table.hashes.each do |admin|
    AdminUser.create!(admin)
  end
end

When(/^the current admin change the rank "([^"]*)" admin email to "([^"]*)"$/) do |id, email|
  visit "/admin/admin_users/#{id}/edit"
  assert_text("Password confirmation")
  fill_in("admin_user_email", with: email)
  fill_in("admin_user_password", with: "12345678")
  fill_in("admin_user_password_confirmation", with: "12345678")
  click_button("Update Admin user")
end