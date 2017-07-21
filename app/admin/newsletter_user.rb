ActiveAdmin.register NewsletterUser do
  filter :email
  filter :created_at
  filter :id
  menu :label => 'Newsletter Subscribers'
  
  sidebar :"How to use" do
    h6 "Batch Actions"
    ul do
      li "Email Selected: Send Email to selected user"
      li "Delete Selected: Unsubscribe selected user"

      end
           
    h6 "Attachment size limit"
    ul do
      li "Gmail: 25Mb (per email)"
      li "Outlook/hotmail: 10Mb (per file attachment)"
      li "Yahoo Mail: 25Mb (per email)"
      li "AOL:	25Mb"
      li "Mail.com:	50Mb (per attachment) and 10Mb (per file)"
      li "Zoho Mail:	12Mb (per email) and 10Mb (per file)"
      li "GoDaddy Workspace: 30Mb (per email) and 20Mb (per file)"
      end   
      
      h6 "Send Email with attachment"
      ul do
      text_node "When sending Email with attachment, upload and mark the attachments in 'File manager', then check 'Include Attachment' to send email with attachment"
      end       
  end
  
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
