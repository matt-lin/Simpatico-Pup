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
    actions if AdminUser.true_admin? current_admin_user.email 
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
      if AdminUser.true_admin? current_admin_user.email 
        super
      else
        flash[:alert] = "Warning: You don't have enough privilege to delete"
        redirect_to "admin/admin_users/"
      end
    end
  end
  
end                                   
