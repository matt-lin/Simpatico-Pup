ActiveAdmin.register NewsletterUser do
  filter :email
  menu :label => 'Newsletter Subscribers'
  
  # Iter 1-2
  batch_action :email, form: {subject: :text, message: :textarea}, confirm: "Please enter the subject and the message below" do |ids, inputs|
    batch_action_collection.find(ids).each do |user|
      if params[:test]
       ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', params[:message], params[:subject], user.email).deliver_now
      else
        ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', inputs[:message], inputs[:subject], user.email).deliver_now
      end
    end
    redirect_to collection_path, notice: "The batch email has been sent to all the users you selected."
  end
  
  actions :all, except: [:update, :show, :edit, :new]
  # End for Iter 1-2
  
  index do
    selectable_column
    
    column :id
    column :email
    column :created_at
    actions
  end

end
