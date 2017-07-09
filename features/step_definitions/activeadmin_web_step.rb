Then(/^I click hidden button "([^"]*)"$/) do |arg1|
  pending
end

When(/^I check batch checkbox "([^"]*)"$/) do |arg1|
  pending
end


# require 'uri'
# require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
# require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# module WithinHelpers
#   def with_scope(locator)
#     locator ? within(*selector_for(locator)) { yield } : yield
#   end
# end
# World(WithinHelpers)

# # Single-line step scoper
# When /^(.*) within (.*[^:])$/ do |step_name, parent|
#   with_scope(parent) { step step_name }
# end

# # Multi-line step scoper
# When /^(.*) within (.*[^:]):$/ do |step_name, parent, table_or_string|
#   with_scope(parent) { step "#{step_name}:", table_or_string }
# end

# Given /^(?:I )am on (.+)$/ do |page_name|
#   visit path_to(page_name)
# end

# # When /^(?:I )go to (.+)$/ do |page_name|
# #   visit path_to(page_name)
# # end

# When /^(?:I )press "([^"]*)"$/ do |button|
#   click_button(button)
# end
# # When /^(?:I )follow "([^"]*)"$/ do |link|
# #   first(:link, link).click
# # end

# When /^(?:I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
#   fill_in(field, with: value)
# end

# When /^(?:I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
#   select(value, from: field)
# end

# When /^(?:I )(check|uncheck|choose) "([^"]*)"$/ do |action, field|
#   send action, field
# end
# When /^(?:I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
#   attach_file(field, File.expand_path(path))
# end

# # Then /^(?:I )should( not)? see( the element)? "([^"]*)"$/ do |negate, is_css, text|
# #   should = negate ? :not_to        : :to
# #   have   = is_css ? have_css(text) : have_content(text)
# #   expect(page).send should, have
# # end

# Then /^the "([^"]*)" field(?: within (.*))? should( not)? contain "([^"]*)"$/ do |field, parent, negate, value|
#   with_scope(parent) do
#     field = find_field(field)
#     value = field.tag_name == 'textarea' ? field.text : field.value

#     expect(value).send negate ? :not_to : :to, match(/#{value}/)
#   end
# end

# Then /^the "([^"]*)" checkbox(?: within (.*))? should( not)? be checked$/ do |label, parent, negate|
#   with_scope(parent) do
#     checkbox = find_field(label)
#     if negate
#       expect(checkbox).not_to be_checked
#     else
#       expect(checkbox).to be_checked
#     end
#   end
# end
# Then /^(?:|I )should be on (.+)$/ do |page_name|
#   expect(URI.parse(current_url).path).to eq path_to page_name
# end
# Then /^show me the page$/ do
#   save_and_open_page
# end

# Then /^I should see a table header with "([^"]*)"$/ do |content|
#   expect(page).to have_xpath '//th', text: content
# end
# Then /^I should not see a table header with "([^"]*)"$/ do |content|
#   expect(page).to_not have_xpath '//th', text: content
# end

# Then /^I should see a sortable table header with "([^"]*)"$/ do |content|
#   expect(page).to have_css 'th.sortable', text: content
# end
# Then /^I should not see a sortable table header with "([^"]*)"$/ do |content|
#   expect(page).to_not have_css 'th.sortable', text: content
# end

# Then /^I should not see a sortable table header$/ do
#   step %{I should not see "th.sortable"}
# end

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