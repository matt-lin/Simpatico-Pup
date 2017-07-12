And /^"([^"]*)" is( not)? in the subscribing group/ do |username, not_in|
  if not_in.nil?
    NewsletterUser.where("email = ?", "#{username}@berkeley.edu").empty?.should == false
  else
    NewsletterUser.where("email = ?", "#{username}@berkeley.edu").empty?.should == true
  end
end

Then (/^All the users should receive an email with "([^"]*)"$/) do |email_body|
  pending
end
