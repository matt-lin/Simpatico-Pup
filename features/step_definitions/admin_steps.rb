#Iter 4-1 provide step definition for admin feature (By Gung Hiu Ho, Licong Wang)
Given (/^the following admin exist:$/) do |admins_table|
  admins_table.hashes.each do |admin|
    AdminUser.create!(admin)
  end
end

When(/^the current admin delete the rank "([^"]*)" admin$/) do |id|
  send "check", "batch_action_item_#{id}"
  page.find("#collection_selection_toggle_all").click
  page.find("#batch_action", visible: false).set :destroy
  form   = page.find "#collection_selection"
  params = page.all("#main_content input", visible: false).each_with_object({}) do |input, obj|
    key, value = input['name'], input['value']
    if key == 'collection_selection[]'
      (obj[key] ||= []).push value if input.checked?
    else
      obj[key] = value
    end
  end
  page.driver.submit form['method'], form['action'], params
  
end