ActiveAdmin.register NewsletterUser do
  filter :email
  menu :label => 'Newsletter Subscribers'
  
  batch_action :email, form: {subject: :text, message: :textarea}, confirm: "Please enter the subject and the message below" do |ids, inputs|
  batch_action_collection.find(ids).each do |user|
    ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', 'your_address_to_reply_to@example.com', inputs[:message], inputs[:subject], user.email).deliver
    # ContactBatchMailer.test_email.deliver
  end
  redirect_to collection_path, notice: "The batch email has been sent to all the users you selected."
end
  
  actions :all, except: [:update, :show, :edit, :new]
  
  index do
    selectable_column
    
    column :id
    column :email
    column :created_at
    actions
  end

end
