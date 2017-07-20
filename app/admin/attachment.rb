ActiveAdmin.register Attachment do
  permit_params :attachment

  config.filters = false
  
  menu :label => 'Attachment Manager'
  actions :all, except: [:edit]
  
  batch_action :select do |ids|
    @lst = []
    batch_action_collection.find(ids).each do |a|
      @unit = a.document_file_name
      @lst.push(@unit)
    end
    SelectedAttachment.change_files @lst
    redirect_to collection_path, notice: "The attachments have been selected."
  end
  
  index do
    selectable_column
    column :document_file_name
    column :document_content_type
    column :document_file_size
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
      row :document_file_name
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

