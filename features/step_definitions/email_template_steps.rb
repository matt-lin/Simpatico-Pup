# Iter3-2 by (Zipei, Jack)
And (/^the following email_templates exist:$/) do |table|
    table.hashes.each do |email_templates|
    EmailTemplate.create!(email_templates)
  end
end

And (/^I send the selected email template$/) do 
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

    EmailTemplate.all.each do |b|
      if b.marked
        b.marked = false
        params[:subject] = b.title
        params[:message] = b.body
      end
      b.save
    end
    
  params[:test] = true
  page.driver.submit form['method'], form['action'], params
end

And (/^I check send email_templates$/) do 
    pending
end
# end Iter3-2