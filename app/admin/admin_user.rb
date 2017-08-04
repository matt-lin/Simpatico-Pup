ActiveAdmin.register AdminUser do
  
  index do                 
    selectable_column
    column :email
    column :owner do |a|
      AdminUser.true_admin? a.email
    end
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count   
    actions
  end

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
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
    
    def delete
      if AdminUser.true_admin? current_admin_user.email
        flash[:notice] = "fa"
        super
      else
        flash[:notice] = "no permission"
        redirect_to admin_admin_user_path()
      end
    end
    
  end
  
end                                   
