require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

def fill(field, value)
    page.execute_script "$('##{field}').val('#{value}');"
end
Then(/^I enter "([^"]*)" and "([^"]*)"$/) do |field, value|
    fill(field, value)   
  end

  Then /^I should see the topic "([^"]*)"$/ do |title|

    assert_text(text, count: 1)
end

Then /^I click link "([^"]*)"$/ do |link|
    click_link(link)
end




