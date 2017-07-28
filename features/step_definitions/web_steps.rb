require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

#Page visiting
When /^(?:I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When(/^(?:admin )go to (.+)$/) do |page_name|
    visit "/admin/"+page_name
end

Given /^(?:I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then /^show me the page$/ do
  save_and_open_page
end

#Page management
When /^I reload the page$/ do
  visit [ current_path, page.driver.request.env['QUERY_STRING'] ].reject(&:blank?).join('?')
end

#Page verification
Then /^(?:|I )should be on (.+)$/ do |page_name|
  expect(URI.parse(current_url).path).to eq path_to page_name
end

#Web Action
When /^(?:I )press "([^"]*)"$/ do |button|
  click_button(button)
end

# Iter 1-2
When /^I press a hidden button "(.*)"$/ do |link|
  find(link, visible: false).click
end
# End for Iter 1-2

When /^(?:I )follow "([^"]*)"$/ do |link|
  first(:link, link).click
end

When /^I select "(.*?)" from "(.*?)"/ do |arg1, arg2|
  page.select arg1, :from => arg2
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
    return #{retval} }")
end

When /^I (accept|deny) confirmation dialogs$/ do |accept|
  page.evaluate_script("window.confirm = function() { return #{(accept == 'accept').to_s}; }")
end

When(/^I hover over "(.*?)"$/) do |element_name|
  page.evaluate_script("$('#{element_name}').trigger('mouseover')")
end

When /^(?:|I )select "([^"]*)" in the dropdown menu "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

#Web enter Action
When /^(?:I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, with: value)
end

When /^(?:I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, from: field)
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

#Iter 2-2 Upload file validation (By Gung Hiu Ho, Licong Wang)
When /^(?:I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

#Web information verification
Then /^I should( not)? see "(.*)"/ do |not_see, text|
  if not_see != nil
		assert_no_text(text)
  else
		assert_text(text)
	end	
end

# Iter 2 - 2 selected comment validation (By Gung Hiu Ho, Licong Wang)
Then /^I will( not)? see "(.*)" or "(.*)"/ do |not_see, text1, text2|
  if not_see != nil
		expect(page.has_no_content?(text1) && page.has_no_content?(text2)).to be (true)
  else
	  expect(page.has_content?(text1) || page.has_content?(text2)).to be (true)
	end	
end
# End for Iter 1-2

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


Then /^I should see a table header with "([^"]*)"$/ do |content|
  expect(page).to have_xpath '//th', text: content
end
Then /^I should not see a table header with "([^"]*)"$/ do |content|
  expect(page).to_not have_xpath '//th', text: content
end

Then /^I should see a sortable table header with "([^"]*)"$/ do |content|
  expect(page).to have_css 'th.sortable', text: content
end
Then /^I should not see a sortable table header with "([^"]*)"$/ do |content|
  expect(page).to_not have_css 'th.sortable', text: content
end

Then /^I should not see a sortable table header$/ do
  step %{I should not see "th.sortable"}
end

Then /^there should be (\d+) "([^"]*)" tags$/ do |count, tag|
  expect(page.all(:css, tag).size).to eq count.to_i
end
Then /^I should see a link to "([^"]*)"$/ do |link|
  expect(page).to have_xpath '//a', text: link
end

Then /^I should see the page title "([^"]*)"$/ do |title|
  within('h2#page_title') do
    expect(page).to have_content title
  end
end
Then /^I should see a fieldset titled "([^"]*)"$/ do |title|
  expect(page).to have_css 'fieldset legend', text: title
end

Then /^I should see a table with id "([^"]*)"$/ do |dom_id|
  page.find("table##{dom_id}")
end

Given /^a confirmation box saying "(.*)" should pop up$/ do |message|
  @expected_message = message
end


# Iter 1-2
Then /^the confirmation box should have been displayed$/ do
  page.evaluate_script("$.cookie('confirm_message')").should_not be_nil
  page.evaluate_script("$.cookie('confirm_message')").should eq(@expected_message)
  page.evaluate_script("$.cookie('confirm_message', null)")
end
# End for Iter 1-2

Given(/^I finished previous steps$/) do
  page.set_rack_session(step1: true)
  page.set_rack_session(step2: true)
  page.set_rack_session(step3: true)
end

When (/^I follow "([^"]*)" for dog1$/) do |link|
  within (".dog1") do
    first(:link, link).click
  end
end

