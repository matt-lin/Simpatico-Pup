And (/^the following email_templates exist:$/) do |table|
    table.hashes.each do |email_templates|
    EmailTemplate.create!(email_templates)
  end
end

# And (/^I send emails with subject as "([^"]*)" and message as "([^"]*)"( with an attachment included)?$/) do |subject, body, attach|
#   action = "email"
#   page.find("#batch_action", visible: false).set action
#   form   = page.find "#collection_selection"
#   params = page.all("#main_content input", visible: false).each_with_object({}) do |input, obj|
#     key, value = input['name'], input['value']
#     if key == 'collection_selection[]'
#       (obj[key] ||= []).push value if input.checked?
#     else
#       obj[key] = value
#     end
#   end

#   params[:subject] = subject
#   params[:message] = body
#   params["Include Attachment"] = attach ? "on" : "off"
#   params[:test] = true
#   page.driver.submit form['method'], form['action'], params
# end

And (/^I check send email_templates$/) do 
    pending
end