require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

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
    if User.find_by_email("testing@berkeley.edu").nil?
      User.create!(
        username: "Testing User",
        email: "testing@berkeley.edu",
        password: "123456789")
    end
  end
end

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
    User.create!(user)
  end
end

And(/^the following newsletter_user exist:/) do |table|
  table.hashes.each do |newsletter_user|
    NewsletterUser.create!(newsletter_user)
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

When /^I select "(.*)" and "(.*)" and search/ do |breed1, breed2|
  choose('multiple_breeds_Mixed_Breed')
  page.select(breed1, :from => 'pup_breed_1')
  page.select(breed2, :from => 'pup_breed_2')
  click_button "Find a Breed"
end

