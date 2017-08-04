ActiveAdmin.register AdminUser do
  
  index do                 
    selectable_column
    column :email
    column :owner do |a|
      a.true_admin a.email
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
    def destroy
      if true_admin 
        redirect_to admin_admin_user_path, notice: "The selected admin has been deleted"
      end
      redirect_to admin_admin_user_path, alert: "Warning: You don't have enough privilege to delete"
    end
  end
end                                   
