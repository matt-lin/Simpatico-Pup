require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

When /^I go to "(.*)"$/ do |link|
  find("#"+link).click
end

Given /the following ratings exist/ do |pups_table|
  breeder = FactoryGirl.create(:breeder, :name => "George W. Bush")
  pups_table.hashes.each do |rating|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Pup.create!(
      pup_name: 'Thor',
    	breed_1: rating['breed_1'],
    	breed_2: rating['breed_2'],
    	breeder_responsibility: rating['breeder_responsibility'],
    	overall_health: rating['overall_health'],
    	trainability: rating['trainability'],
    	social_behavior: rating['social_behavior'],
    	energy_level: rating['energy_level'],
    	simpatico_rating: rating['simpatico_rating'],
    	comments: rating['comments'],
    	user_id: "Testing User",
    	breeder_id: breeder.id)
  end
end

Given /the following comments exist/ do |pups_table|
  breeder = FactoryGirl.create(:breeder, :name => "George W. Bush")
  pups_table.hashes.each do |rating|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Pup.create!(
      pup_name: 'Thor',
    	breed_1: rating['breed_1'],
    	breed_2: rating['breed_2'],
    	breeder_responsibility: rating['breeder_responsibility'],
    	overall_health: rating['overall_health'],
    	trainability: rating['trainability'],
    	social_behavior: rating['social_behavior'],
    	energy_level: rating['energy_level'],
    	simpatico_rating: rating['simpatico_rating'],
    	comments: rating['comments'],
    	user_id: 1,
    	breeder_id: breeder.id)
    Comment.create!(
      content: rating['comments'],
      pup_id: '1')
    User.create!(
      username: "Testing User",
      email: "testing@berkeley.edu",
      password: "123456789"
  )
  end
end

Given /^I am on (.+)/ do |page_name|
	visit path_to(page_name)
end

When /^I select "(.*?)" from "(.*?)"/ do |arg1, arg2|
  page.select arg1, :from => arg2
end


When /^I press "(.*)"/ do |button|
	click_button(button)
end

When /^I follow "(.*)"$/ do |link|
  click_link(link)
end

When /^I press a hidden button "(.*)"$/ do |link|
  find(link, visible: false).click
end

Then /^I should( not)? see "(.*)"/ do |not_see, text|
  if not_see != nil
		assert_no_text(text)
  else
		assert_text(text)
	end	
end

Then /^I should( not)? see twice "(.*)"/ do |not_see, text|
  if not_see != nil
		assert_no_text(text, count: 2)
  else
		assert_text(text, count: 2)
	end	
end

Then /^I should see todays date/ do
  assert page.has_no_content?(Date.today)
end

Then /^I should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

When /^I fill out the form with the following attributes:$/ do |pups_table|
  page.evaluate_script "$('#multiple_breeds').trigger('click');"
  pups_table.hashes.each do |rating|

    choose('multiple_breeds_Mixed_Breed')
    page.select rating['breed_1'], :from => 'pup_breed_1'
    page.select rating['breed_2'], :from => 'pup_breed_2'
    slide('slider-breeder', rating['breeder_responsibility'])
    slide('slider-health', rating['overall_health'])
    slide('slider-train', rating['trainability'])
    slide('slider-social', rating['social_behavior'])
    slide('slider-energy', rating['energy_level'])
    slide('slider-simpatico', rating['simpatico_rating'])
    fill_in 'Comments', :with => rating['comments']
    fill_in 'Name', :with => rating['pup_name']
    
  end
end

Then /^I should see all of:/ do |names|
  names.hashes.each do |name|
    page.has_content?(name['name'])
  end
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )select "([^"]*)" in the dropdown menu "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

#NEW
When /^I click on "([^\"]+)"$/ do |text|
  matcher = ['*', { :text => text }]
  element = page.find(:css, *matcher)
  while better_match = element.first(:css, *matcher)
    element = better_match
  end
  element.click
end
#END OF NEW

Given(/^the following breeders exist:$/) do |table|
  table.hashes.each do |breeder|
    FactoryGirl.create(:breeder, :name => breeder[:name], :city => breeder[:city], :state => breeder[:state])
  end
end

Given(/^the following breeds exist:$/) do |table|
  table.hashes.each do |breed|
    FactoryGirl.create(:breed, :name => breed[:name])
  end
end

When(/^I enter "(.*?)" into "(.*?)"$/) do |value, field|
  fill_in(field, :with => value)
end

When /^I enter "(.*?)" into autocomplete "(.*?)" with "(.*)"$/ do |value, field, event|
  auto_complete(field, value, event)
end

When /^I enter "(.*?)", "(.*?)", "(.*?)" into breeder search$/ do |name, city, state|
  fill("breeder_city", city)
  fill("breeder_state", state)
  fill_and_trigger("breeder_find", name, "keyup")
end

When /^I select "(.*)" and "(.*)" and search/ do |breed1, breed2|
  choose('multiple_breeds_Mixed_Breed')
  page.select(breed1, :from => 'pup_breed_1')
  page.select(breed2, :from => 'pup_breed_2')
  click_button "Find a Breed"
end

Then /^I should( not)? see Secondary breed after clicking My dog is a mixed breed/ do |negatory|
  page.evaluate_script "$('#multiple_breeds').trigger('click');"
  if negatory != nil
    expect(page).to have_selector('#multiple_breeds', visible: false)
  else
    expect(page).to have_selector('#multiple_breeds', visible: true)
  end
end


When(/^I am logged in$/) do
  @user = FactoryGirl.create(:user)
  click_link("Login")
  fill_in(:user_email, :with => "lolright@aol.com")
  fill_in(:user_password, :with => "lolright")
  click_button("Log in")
  assert_text("Logout")
end

def set_hidden_field(field, value)
  page.execute_script "s=$('##{field}');"
  page.execute_script "s.val(#{value})"
end

def slide(slidr, value)
  page.execute_script "s=$('#slidr');"
  page.execute_script "s.slider('option', 'value', #{value})"
end

def auto_complete(text_field, value, event='keyup')
  page.execute_script "s = $('##{text_field}');"
  page.execute_script "s.val('#{value}').#{event}();"
end

def fill(field, value)
  page.execute_script "$('##{field}').val('#{value}');"
end

def fill_and_trigger(field, value, event_type)
  page.execute_script "s = $('##{field}');"
  page.execute_script "s.val('#{value}').#{event_type}();"
end

Given /^a confirmation box saying "(.*)" should pop up$/ do |message|
  @expected_message = message
end

Given /^I want to click "(.*)"$/ do |option|
  retval = (option == "Ok") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
end

Then /^the confirmation box should have been displayed$/ do
  page.evaluate_script("$.cookie('confirm_message')").should_not be_nil
  page.evaluate_script("$.cookie('confirm_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('confirm_message', null)")
end

Given /^I click "(.*)"$/ do |click|
  page.evaluate_script("$('#{click}').click()")
end

When(/^I visit "([^"]*)"$/) do |url|
  visit(url)
end

Given (/^I login as an admin$/) do
  @admin_user = FactoryGirl.create(:admin_user)
  visit('/admin/login')
  fill_in(:admin_user_email, :with => 'admin@berkeley.edu')
  fill_in(:admin_user_password, :with => 'password')
  find("#admin_user_submit_action").find("input").click
end

When(/^I hover over "(.*?)"$/) do |element_name|
  page.evaluate_script("$('#{element_name}').trigger('mouseover')")
end

When(/^I choose "([^"]*)"$/) do |check_box_id|
  choose(check_box_id)
end

Given(/^I finished previous steps$/) do
  page.set_rack_session(step1: true)
  page.set_rack_session(step2: true)
  page.set_rack_session(step3: true)
end