# Iter 3-2 (By Gung Hiu Ho, Licong Wang)
ActiveAdmin.register Customize do
  config.clear_sidebar_sections!
  index do
    table_for Customize.all do
      column :name 
      column :content
      actions
    end
  end
    
  show do
    attributes_table do
      row :name
      row :conent
    end
  end
    
  controller do
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
# End for Iter 3-2