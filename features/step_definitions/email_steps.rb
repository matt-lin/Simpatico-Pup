#Iter 2-2
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

And (/^I send emails with subject as "([^"]*)" and message as "([^"]*)"$/) do |subject, body|
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
  params[:test] = true
  page.driver.submit form['method'], form['action'], params
end

Then (/^all the users should get an email with "([^"]*)" and "([^"]*)"$/) do |subject, body|
  emails = ActionMailer::Base.deliveries
  emails.length.should == NewsletterUser.all.length
  NewsletterUser.all.each do |user|
    user_email = emails.select{|email| email.to.include? user.email}
    user_email.size.should == 1
    expect(user_email.first).to have_content(subject)
    expect(user_email.first).to have_content(body)
  end
end

Then (/^"([^"]*)" (should|should not) get an email with "([^"]*)" and "([^"]*)"$/) do |username, maybe, subject, body|
  emails = ActionMailer::Base.deliveries
  user_email = emails.select{|email| email.to.include? "#{username}@berkeley.edu"}
  if maybe == 'should'
    user_email.size.should == 1
    expect(user_email.first).to have_content(subject)
    expect(user_email.first).to have_content(body)
  else 
    user_email.size.should == 0
  end
end

#Iter 2-1

When (/^"([^"]*)" go to the link contained by the sent email$/) do |username|
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'Reset password'
end

Given (/^I enter "([^"]*)"'s email and click on the url from the sent email$/) do |username|
  fill_in("password_reset[email]", with: "#{username}@berkeley.edu")
  click_button("Submit")
  open_email("#{username}@berkeley.edu")
  current_email.click_link 'Reset password'
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



