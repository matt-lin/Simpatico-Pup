And (/^the following email_templates exist:$/) do |table|
    table.hashes.each do |email_templates|
    EmailTemplate.create!(email_templates)
  end
end


And (/^I check send email_templates$/) do 
    pending
end