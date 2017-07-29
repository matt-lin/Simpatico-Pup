require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /the following pups exist/ do |pups_table|
  pups_table.hashes.each do |p|
    Pup.create!(p)
  end
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

# Iter 1-2
Given /the following comments exist/ do |pups_table|
  breeder = FactoryGirl.create(:breeder, :name => "George W. Bush")
  pups_table.hashes.each do |rating|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    pup = Pup.create!(
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
    	breeder_id: breeder.id,
    	breed_id: 1)
    Comment.create!(
      content: rating['comments'],
      pup_id: pup.id)
    Breed.create!(name: rating['breed_1'])
    if User.find_by_email("testing@berkeley.edu").nil?
      User.create!(
        username: "Testing User",
        email: "testing@berkeley.edu",
        password: "123456789")
    end
  end
end

Given(/^the following breeders exist( for search)?:$/) do |for_search, table|
  table.hashes.each do |breeder|
    breeder = FactoryGirl.create(:breeder, :name => breeder[:name], :city => breeder[:city], :state => breeder[:state])
    # Add a pup used by searching breeder
    if for_search
      FactoryGirl.create(:pup, :breeder_id => breeder.id)
    end
  end
end

Given(/^the following breeds exist:$/) do |table|
  table.hashes.each do |breed|
    FactoryGirl.create(:breed, :name => breed[:name])
  end
end
# End for Iter 1-2

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

And(/^the following users exist:/) do |table|
  table.hashes.each do |user|
    u = User.create!(user)
    if user[:activated] == "true"
      u.activated = true
      u.save!
    end
  end
end

# Iter 1-2
And(/^the following newsletter_user exist:/) do |table|
  table.hashes.each do |newsletter_user|
    NewsletterUser.create!(newsletter_user)
  end
end
# End for Iter 1-2

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

When /^I select "(.*)" and "(.*)" and search/ do |breed1, breed2|
  choose('multiple_breeds_Mixed_Breed')
  page.select(breed1, :from => 'pup_breed_1')
  page.select(breed2, :from => 'pup_breed_2')
  click_button "Find a Breed"
end

# Iter 2-2 Breeder location validation (By Gilbert Lo, Jeff Yu)
When /^I fill in the new breeder form with following: (.*)/ do |args|
  info_list = args.split(", ")

  steps %Q{
    When I fill in "breeder_name" with "#{info_list[0]}" 
    Then I fill in "breeder_city" with "#{info_list[1]}"
  }
  if info_list[2] != "empty"
    steps %Q{And I select "#{info_list[2]}" in the dropdown menu "breeder_state"}
  end
end

When /^I fill in the search breeder form with following: (.*)/ do |args|
  info_list = args.split(", ")
  if info_list[0] != "Any"
    step %Q{And I select "#{info_list[0]}" in the dropdown menu "breeder_breed_name"}
  end
  steps %Q{
    Then I fill in "breeder_city" with "#{info_list[1]}"
    And I select "#{info_list[2]}" in the dropdown menu "breeder_state"
    And I select "#{info_list[3]}" in the dropdown menu "breeder_search_distance"
  }
end
#End iter 2-2

When /^I fill in with a non-existing breeder/ do
  steps %Q{
    When I fill in "breeder_str" with "Invalid breeder"
  }
end

When /^I fill in new info/ do
  steps %Q{
    When I select "10" in the dropdown menu "pup_years"
    And I select "10" in the dropdown menu "pup_months"
    And I select "Affenpinscher" in the dropdown menu "breed"
    And I fill in "breeder_str" with "Carl - Berkeley, CA"
    And I fill in "comment" with "Test"
  }
  # fifith = 5, sixth = 0
  page.find("#breeder-label-fifth").trigger(:click)
  page.find("#health-label-fifth").trigger(:click)
  page.find("#train-label-fifth").trigger(:click)
  page.find("#social-label-fifth").trigger(:click)
  page.find("#behavior-label-fifth").trigger(:click)
  page.find("#energy-label-fifth").trigger(:click)
  page.find("#simpatico-label-sixth").trigger(:click)
  # HardToObedienceTrain and VeryQuiet
  page.find("#hashtag1").trigger(:click)
  page.find("#hashtag7").trigger(:click)
end

When /^I should see correct info updated/ do
  steps %Q{
    Then I should see "Owned For: 10 year(s) and 10 month(s)"
    And  I should see "Breed: Affenpinscher"
    And  I should see "Breeder: Carl"
    And  I should see "Test"
    And  I should see "#HardToObedienceTrain"
    And  I should see "#VeryQuiet"
  }
  page.find('#breeder_score')['innerHTML'].should == "5"
  page.find('#health_score')['innerHTML'].should == "5"
  page.find('#train_score')['innerHTML'].should == "5"
  page.find('#social_score')['innerHTML'].should == "5"
  page.find('#energy_score')['innerHTML'].should == "5"
  page.find('#simpatico_score')['innerHTML'].should == "N/A"
end

When /^I should see correct info of dog1/ do
  steps %Q{
    Then  I should see "Breeder: Juju"
    And   I should see "Breed: Afghan Hound"
    And   I should see "Owned For: 1 year(s) and 1 month(s)"
  }
end

When /^I finish adding a new breeder$/ do
  steps %Q{
    When I fill in "breeder_name" with "Jeff Yu"
    And I fill in "breeder_city" with "Berkeley"
    And I select "CA" in the dropdown menu "breeder_state"
    And I press "Add_Breeder"
  }
end

