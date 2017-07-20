ActiveAdmin.register Attachment do
  permit_params :attachment

  config.filters = false
  
  menu :label => 'Attachment Manager'
  actions :all, except: [:edit]
  
  index do
    selectable_column
    column :document_file_name
    column :document_content_type
    column :document_file_size
    actions
  end

  form do |f|
    f.inputs "Firmware" do
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
      @attachment = Attachment.new(document: params[:document])
      @attachment[:document_file_name] = attrs[:attachment].original_filename
      @attachment[:document_content_type] = attrs[:attachment].content_type
      @attachment[:document_file_size] = attrs[:attachment].size
      @attachment.document = attrs[:attachment]

      if @attachment.save
        redirect_to admin_attachments_path, notice: "The attachment has been uploaded."
      else
        render :new, notice: "Invalid file, please try again"
      end
    end

    def update
      attrs = permitted_params[:attachment]

      @attachment = Attachment.where(id: params[:id]).first!
      #@attachment.firmware_level = attrs[:firmware_level]

      @attachment[:document_file_name] = attrs[:attachment].original_filename
      #@attachment[:attachment] = attrs[:attachment].read

      if @attachment.save
        redirect_to admin_attachment_path(@attachment)
      else
        render :edit
      end
    end
  end
end

