#Iter 2-2
ActiveAdmin.register Attachment do
  permit_params :attachment
  
  menu :label => 'File Manager'
  index :title => 'File Manager'
  actions :all, except: [:edit]
  filter :document_file_name
  filter :document_file_size
  filter :marked
  
  config.clear_action_items!
  action_item :only => :index do
    link_to "Upload File" , "/admin/attachments/new" 
  end
  
  sidebar :"How to use" do
    h6 "Batch Actions"
    ul do
      li "Mark Selected: Mark the files as pending attachment"
      li "Unmark Selected: Remove marked the files from pending attachment"
      li "Delete Selected: Permanently remove the marked the files from the site"
      end
           
    h6 "File size limit"
    ul do
      li "local: Unlimited"
      li "Gmail: 25Mb (per email)"
      li "Outlook/hotmail: 10Mb (per file attachment)"
      li "Yahoo Mail: 25Mb (per email)"
      li "AOL:	25Mb"
      li "Mail.com:	50Mb (per attachment) and 10Mb (per file)"
      li "Zoho Mail:	12Mb (per email) and 10Mb (per file)"
      li "GoDaddy Workspace: 30Mb (per email) and 20Mb (per file)"
      end       
      
    text_node "Following file type will not send from email: 
    .ADE, .ADP, .BAT, .CHM, .CMD, .COM, .CPL, .EXE, .HTA, .INS, .ISP, .JAR, 
    .JS (NEW), .JSE, .LIB, .LNK, .MDE, .MSC, .MSI, .MSP, .MST, .NSH .PIF, .SCR, 
    .SCT, .SHB, .SYS, .VB, .VBE, .VBS, .VXD, .WSC, .WSF, .WSH"
  end
  
  batch_action :mark do |ids|
    batch_action_collection.find(ids).each do |a|
      a.marked = true
      a.save
    end
    redirect_to collection_path, notice: "The selected attachments have been marked and will be attached in email."
  end
  
  batch_action :unmark do |ids|
    batch_action_collection.find(ids).each do |a|
      a.marked = false
      a.save
    end
    redirect_to collection_path, notice: "The selected attachments have been unmarked and will not be attached in email."
  end
  
  index do
    selectable_column
    attachment_column :document
    number_column :document_file_size, as: :human_size
    bool_column :marked
    actions
  end

  form do |f|
    f.inputs "Upload File" do
      f.input :attachment, as: :file
    end
    f.actions
  end

  show do
    attributes_table do
      attachment_row("File", :document, label: 'Download file', truncate: false)
      row :document_content_type
      row :document_file_size
    end
  end

  controller do

    def create
      attrs = permitted_params[:attachment]
      @empty = true
      @attachment = Attachment.new(document: params[:document])
      
      if !attrs.nil?
        @empty = false
        @attachment[:document_file_name] = attrs[:attachment].original_filename
        @attachment[:document_content_type] = attrs[:attachment].content_type
        @attachment[:document_file_size] = attrs[:attachment].size
        @attachment.document = attrs[:attachment]
        @attachment.save!
      end

      if !@empty
        redirect_to admin_attachments_path, notice: "The attachment has been uploaded."
      else
        redirect_to admin_attachments_path, alert: "Invalid upload, please try again."
      end
    end

    def update
      attrs = permitted_params[:attachment]
      @attachment = Attachment.where(id: params[:id]).first!
      @attachment[:document_file_name] = attrs[:attachment].original_filename
      if @attachment.save
        redirect_to admin_attachment_path(@attachment)
      else
        render :edit
      end
    end
  end
end
#End of Iter 2-2
