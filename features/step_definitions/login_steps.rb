# Iter 1-2
Given (/^I login as an admin$/) do
  @admin_user = FactoryGirl.create(:admin_user)
  visit('/admin/login')
  fill_in(:admin_user_email, :with => 'admin@berkeley.edu')
  fill_in(:admin_user_password, :with => 'password')
  find("#admin_user_submit_action").find("input").click
end
# End for Iter 1-2

Given(/^I log in as "([^"]*)"/) do |user_name|
  click_link("Login")
  fill_in(:user_email, :with => "#{user_name}@berkeley.edu")
  fill_in(:user_password, :with => "12345678")
  click_button("Log in")
  # assert_text("Logout")
end

When(/^I am logged in$/) do
  @user = FactoryGirl.create(:user)
  click_link("Login")
  fill_in(:user_email, :with => "lolright@aol.com")
  fill_in(:user_password, :with => "lolright")
  click_button("Log in")
  assert_text("Logout")
end

When(/^I should have logged in as "([^"]*)"/) do |arg1|
  pending
end
