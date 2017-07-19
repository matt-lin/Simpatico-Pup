# Iter 1-2
And /^"([^"]*)" is( not)? in the subscribing group/ do |username, not_in|
  if not_in.nil?
    NewsletterUser.where("email = ?", "#{username}@berkeley.edu").empty?.should == false
  else
    NewsletterUser.where("email = ?", "#{username}@berkeley.edu").empty?.should == true
  end
end

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

Given (/^there is no subscribers/) do
  NewsletterUser.delete_all
end

Then (/^check all subscribers/) do 
  (1..NewsletterUser.all.length).each do |index|
    calling_step = 'I check "batch_action_item_"'
    calling_step.insert(-2, index.to_s)
    step calling_step
  end
end


# attachment part not implemented  
And (/^I send emails with subject as "([^"]*)" and message as "([^"]*)"( with an attachment)?$/) do |subject, body, attach|
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

Then (/^all the users should get an email with "([^"]*)" and "([^"]*)"( with an attachment)?$/) do |subject, body, attach|
  emails = ActionMailer::Base.deliveries
  emails.length.should == NewsletterUser.all.length
  NewsletterUser.all.each do |user|
    user_email = emails.select{|email| email.to.include? user.email}
    user_email.size.should == 1
    expect(user_email.first).to have_content(subject)
    expect(user_email.first).to have_content(body)
  end
end

Then (/^"([^"]*)" (should|should not) get an email with "([^"]*)" and "([^"]*)"( with an attachment)?$/) do |username, maybe, subject, body, attach|
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
# End for Iter 1-2