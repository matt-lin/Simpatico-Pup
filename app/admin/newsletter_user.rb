ActiveAdmin.register NewsletterUser do
  filter :email
  filter :created_at
  filter :id
  menu :label => 'Newsletter Subscribers'
  
  # Iter 2-2
  batch_action :email, form: {
      subject: :text,
      message: :textarea ,
      "Include Attachment": :checkbox
    }, confirm: "Please enter the subject and the message below" do |ids, inputs|
    batch_action_collection.find(ids).each do |user|
      if params[:test]
        ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', params[:message], params[:subject], user.email, params["Include Attachment"]).deliver_now
      else
        ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', inputs[:message], inputs[:subject], user.email, inputs["Include Attachment"]).deliver_now
      end
    end
    Attachment.all.each do |a|
      a.marked = false
      a.save
    end
    redirect_to collection_path, notice: "The batch email has been sent to all the users you selected."
  end
  
  actions :all, except: [:update, :show, :edit, :new]
  # End for Iter 2-2
  
  index do
    selectable_column
    column :id
    column :email
    column :created_at
    actions
  end

end
