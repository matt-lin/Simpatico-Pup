require 'uri'
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

When(/^(?:admin )go to (.+)$/) do |page_name|
    visit "/admin/"+page_name
end

Given /^(?:I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I reload the page$/ do
  visit [ current_path, page.driver.request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
end

# # Single-line step scoper
# When /^(.*) within (.*[^:])$/ do |step_name, parent|
#   with_scope(parent) { step step_name }
# end

# # Multi-line step scoper
# When /^(.*) within (.*[^:]):$/ do |step_name, parent, table_or_string|
#   with_scope(parent) { step "#{step_name}:", table_or_string }
# end

# # When /^(?:I )go to (.+)$/ do |page_name|
# #   visit path_to(page_name)
# # end

When /^(?:I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^I press a hidden button "(.*)"$/ do |link|
  find(link, visible: false).click
end

When /^(?:I )follow "([^"]*)"$/ do |link|
  first(:link, link).click
end

# When /^(?:I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
#   fill_in(field, with: value)
# end

# When /^(?:I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
#   select(value, from: field)
# end

Then /^I should( not)? see "(.*)"/ do |not_see, text|
  if not_see != nil
		assert_no_text(text)
  else
		assert_text(text)
	end	
end

Then /^I should see todays date/ do
  assert page.has_no_content?(Date.today)
end

Then /^I should( not)? see twice "(.*)"/ do |not_see, text|
  if not_see != nil
		assert_no_text(text, count: 2)
  else
		assert_text(text, count: 2)
	end	
end

Then /^I should see all of:/ do |names|
  names.hashes.each do |name|
    page.has_content?(name['name'])
  end
end

When /^I select "(.*?)" from "(.*?)"/ do |arg1, arg2|
  page.select arg1, :from => arg2
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

When /^(?:I )(check|uncheck|choose) "([^"]*)"$/ do |action, field|
  send action, field
end

Given /^I click "(.*)"$/ do |click|
  page.evaluate_script("$('#{click}').click()")
end

Given /^I want to click "(.*)"$/ do |option|
  retval = (option == "Ok") ? "true" : "false"

  page.evaluate_script("window.confirm = function (msg) {
    $.cookie('confirm_message', msg)
    return #{retval}
  }")
end


When(/^I hover over "(.*?)"$/) do |element_name|
  page.evaluate_script("$('#{element_name}').trigger('mouseover')")
end


Then /^(?:admin )should( not)? see( the element)? "([^"]*)"$/ do |negate, is_css, text|
  should = negate ? :not_to        : :to
  have   = is_css ? have_css(text) : have_content(text)
  expect(page).send should, have
end

Then /^I should( not)? see Secondary breed after clicking My dog is a mixed breed/ do |negatory|
  page.evaluate_script "$('#multiple_breeds').trigger('click');"
  if negatory != nil
    expect(page).to have_selector('#multiple_breeds', visible: false)
  else
    expect(page).to have_selector('#multiple_breeds', visible: true)
  end
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )select "([^"]*)" in the dropdown menu "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  expect(URI.parse(current_url).path).to eq path_to page_name
end
Then /^show me the page$/ do
  save_and_open_page
end

# Then /^I should see a table header with "([^"]*)"$/ do |content|
#   expect(page).to have_xpath '//th', text: content
# end
# Then /^I should not see a table header with "([^"]*)"$/ do |content|
#   expect(page).to_not have_xpath '//th', text: content
# end

Then /^I should see a sortable table header with "([^"]*)"$/ do |content|
  expect(page).to have_css 'th.sortable', text: content
end
Then /^I should not see a sortable table header with "([^"]*)"$/ do |content|
  expect(page).to_not have_css 'th.sortable', text: content
end

Then /^I should not see a sortable table header$/ do
  step %{I should not see "th.sortable"}
end

# Then /^the table "([^"]*)" should have (\d+) rows/ do |selector, count|
#   trs = page.find(selector).all :css, 'tr'
#   expect(trs.size).to eq count.to_i
# end
# Then /^the table "([^"]*)" should have (\d+) columns/ do |selector, count|
#   tds = page.find(selector).find('tr:first').all :css, 'td'
#   expect(tds.size).to eq count.to_i
# end

# Then /^there should be (\d+) "([^"]*)" tags$/ do |count, tag|
#   expect(page.all(:css, tag).size).to eq count.to_i
# end
# Then /^I should see a link to "([^"]*)"$/ do |link|
#   expect(page).to have_xpath '//a', text: link
# end

# Then /^an "([^"]*)" exception should be raised when I follow "([^"]*)"$/ do |error, link|
#   expect {
#     step "I follow \"#{link}\""
#   }.to raise_error(error.constantize)
# end

# Then /^I should be in the resource section for (.+)$/ do |resource_name|
#   expect(current_url).to include resource_name.tr(' ', '').underscore.pluralize
# end

# Then /^I should wait and see "([^"]*)"(?: within "([^"]*)")?$/ do |text, selector|
#   sleep 1
#   step 'show me the page'
#   selector ||= "*"
#   locate(:xpath, "//#{selector}[text()='#{text}']")
# end

# Then /^I should see the page title "([^"]*)"$/ do |title|
#   within('h2#page_title') do
#     expect(page).to have_content title
#   end
# end
# Then /^I should see a fieldset titled "([^"]*)"$/ do |title|
#   expect(page).to have_css 'fieldset legend', text: title
# end

# Then /^the "([^"]*)" field should contain the option "([^"]*)"$/ do |field, option|
#   field = find_field(field)
#   expect(field).to have_css 'option', text: option
# end

# Then /^I should see the content "([^"]*)"$/ do |content|
#   expect(page).to have_css '#active_admin_content', text: content
# end
# Then /^I should see a validation error "([^"]*)"$/ do |error_message|
#   expect(page).to have_css '.inline-errors', text: error_message
# end

# Then /^I should see a table with id "([^"]*)"$/ do |dom_id|
#   page.find("table##{dom_id}")
# end

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


Given /^a confirmation box saying "(.*)" should pop up$/ do |message|
  @expected_message = message
end

Then /^the confirmation box should have been displayed$/ do
  page.evaluate_script("$.cookie('confirm_message')").should_not be_nil
  page.evaluate_script("$.cookie('confirm_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('confirm_message', null)")
end

Given(/^I finished previous steps$/) do
  page.set_rack_session(step1: true)
  page.set_rack_session(step2: true)
  page.set_rack_session(step3: true)
end