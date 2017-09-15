#Iter 2-2 redeign the functionality of newsletter_user page (By Gung Hiu Ho, Licong Wang) [originally created by: Gilbert Lo]
ActiveAdmin.register NewsletterUser do
  
  filter :email
  filter :created_at
  filter :id
  menu :label => 'Newsletter Subscribers'
  menu :priority => 9
  
  sidebar :"How to use" do
    h6 "Batch Actions"
    ul do
      li "Email Selected: Send Email to selected user"
      li "Delete Selected: Unsubscribe selected user"
    end
      
    h6 "Email with attachment"
    ul do
      text_node "When sending Email with attachment, upload and mark the attachments in 'File manager', then check 'Include Attachment' to send email with attachment"
    end       
  end
  
  
  batch_action :email, form: {
      subject: :text,
      message: :textarea,
      "Include Attachment" => :checkbox,
      "Include Email Template" => :checkbox
    }, confirm: "Please enter the subject and the message below" do |ids, inputs|
    batch_action_collection.find(ids).each do |user|
      if inputs["Include Email Template"]
        EmailTemplate.all.each do |b|
          if b.marked
            b.marked = false
            inputs[:subject] = b.title
            inputs[:message] = b.body
          end
          b.save
        end
      end
      
      if params[:test]
        ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', params[:message], params[:subject], user.email, params["Include Attachment"]).deliver_now
      else
        ContactBatchMailer.contact_batch_email('Dear Newsletter Subscribers', inputs[:message], inputs[:subject], user.email, inputs["Include Attachment"]).deliver_now
      end
    end
    
    @sent = []
    Attachment.all.each do |a|
      if a.marked
        a.marked = false
        @sent.push(a.document_file_name)
      end
      a.save
    end
    if (params["Include Attachment"] == "on" || inputs["Include Attachment"] == "on") && !@sent.empty?
      flash[:notice] = "The batch email has been sent to all the users you selected. Attachment: #{@sent.join(", ")}"
    else 
      flash[:notice] = "The batch email has been sent to all the users you selected #{inputs[:message]}. No attachment selected"
    end
    @sent.clear
    redirect_to collection_path
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
