# Iter 1-2
And /^"([^"]*)" is( not)? in the subscribing group/ do |username, not_in|
  if not_in.nil?
    NewsletterUser.where("email = ?", "#{username}@berkeley.edu").empty?.should == false
  else
    NewsletterUser.where("email = ?", "#{username}@berkeley.edu").empty?.should == true
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
