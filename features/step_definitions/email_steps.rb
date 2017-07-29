#Iter 1
Then (/^all the users should receive an email$/) do 
  emails = ActionMailer::Base.deliveries
  emails.length.should == NewsletterUser.all.length
  NewsletterUser.all.each do |user|
    user_email = emails.select{|email| email.to.include? user.email}.size
    user_email.should == 1
  end
end

Then (/^"([^"]*)" (should|should not) receive an email$/) do |username, maybe|
  emails = ActionMailer::Base.deliveries
  user_email = emails.select{|email| email.to.include? "#{username}@berkeley.edu"}.size
  if maybe == 'should'
    user_email.should == 1
  else 
    user_email.should == 0
  end
end

When (/^"([^"]*)" simply open the email$/) do |username|
  open_email("#{username}@berkeley.edu")
end

And (/^I send emails with subject as "([^"]*)" and message as "([^"]*)"( with an attachment included)?$/) do |subject, body, attach|
  action = "email"
  page.find("#batch_action", visible: false).set action
  form   = page.find "#collection_selection"
  params = page.all("#main_content input", visible: false).each_with_object({}) do |input, obj|
    key, value = input['name'], input['value']
    if key == 'collection_selection[]'
      (obj[key] ||= []).push value if input.checked?
    else
      obj[key] = value
    end
  end

  params[:subject] = subject
  params[:message] = body
  params["Include Attachment"] = attach ? "on" : "off"
  params[:test] = true
  page.driver.submit form['method'], form['action'], params
end
#End for Iter1

#Iter 2-2 upload attachment validation (By Gung Hiu Ho, Licong Wang)
Then (/^all the users should get an email with "([^"]*)" and "([^"]*)"( with an attachment "([^"]*)")?$/) do |subject, body, attach, file|
  emails = ActionMailer::Base.deliveries
  emails.length.should == NewsletterUser.all.length
  NewsletterUser.all.each do |user|
    user_email = emails.select{|email| email.to.include? user.email}
    user_email.size.should == 1
    expect(user_email.first).to have_content(subject)
    expect(user_email.first).to have_content(body)
    expect(user_email.first.attachments.first.filename).to eq file if attach
  end
end

Then (/^"([^"]*)" (should|should not) get an email with "([^"]*)" and "([^"]*)"( with an attachment "([^"]*)")?$/) do |username, maybe, subject, body, attach, file|
  emails = ActionMailer::Base.deliveries
  user_email = emails.select{|email| email.to.include? "#{username}@berkeley.edu"}
  if maybe == 'should'
    user_email.size.should == 1
    expect(user_email.first).to have_content(subject)
    expect(user_email.first).to have_content(body)
    expect(user_email.first.attachments.first.filename).to eq file if attach
  else 
    user_email.size.should == 0
  end
end

When (/^"([^"]*)" go to the link contained by the sent email$/) do |username|
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'Reset password'
end

When (/^"([^"]*)" go to the link to unsubscribe newsletter$/) do |username|
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'here'
end

Given (/^I enter "([^"]*)"'s email and click on the url from the sent email$/) do |username|
  fill_in("password_reset[email]", with: "#{username}@berkeley.edu")
  click_button("Submit")
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'Reset password'
end

Given (/^I enter "([^"]*)"'s mailbox and click on the activate in sent email$/) do |username|
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'Activate'
end

Given (/^I enter "([^"]*)"'s mailbox and click on the activate in sent email twice$/) do |username|
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'Activate'
  current_email.click_link 'Activate'
end

And (/^I enter (valid|invalid) new password info and press "([^"]*)"$/) do |maybe, button|
  if maybe == 'valid'
    fill_in("user[password]", with: "00000000")
    fill_in("user[password_confirmation]", with: "00000000")
  else
    fill_in("user[password]", with: "00")
    fill_in("user[password_confirmation]", with: "00")
  end
  click_button(button)
end

And (/^I enter different password info and press "([^"]*)"$/) do |button|
  fill_in("user[password]", with: "00000000")
  fill_in("user[password_confirmation]", with: "11111111")
  click_button(button)
end


When (/^I enter "([^"]*)"'s email and new password and log in$/) do |username|
    fill_in("user[email]", with: "#{username}@berkeley.edu")
    fill_in("user[password]", with: "00000000")
    click_button("Log in")
end

And (/^I click on that url again$/) do
    current_email.click_link 'Reset password'
end

#Iter 2-2 upload file validation (By Gung Hiu Ho, Licong Wang)
Given (/^I have uploaded a file named "([^"]*)"$/) do |file|
  first(:link, "Upload File").click
  attach_file("attachment_attachment", File.expand_path("features/attachment/#{file}"))
  click_button("Create Attachment")
end

When (/^I (mark|unmark) this uploaded file$/) do |marked|
  send "check", "batch_action_item_1"
  page.find("#collection_selection_toggle_all").click
  if marked == "mark"
    page.find("#batch_action", visible: false).set "mark"
  elsif marked == "unmark"
    page.find("#batch_action", visible: false).set "unmark"
  end
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

And (/^"([^"]*)" wait for 31 mins$/) do |username|
    @user = User.where("username = ?", username).first
    @user.update_attribute(:reset_password_sent_at, Time.zone.now-1860)
end

#Iter 2-2 upload file validation (By Gung Hiu Ho, Licong Wang)
When (/^I delete this uploaded file$/) do
  send "check", "batch_action_item_1"
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
#End for Iter 2-2

When (/^"([^"]*)" simply open the email$/) do |username|
  open_email("#{username}@berkeley.edu")
end

When (/^"([^"]*)" go to the link to unsubscribe newsletter$/) do |username|
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'here'
end
