ActiveAdmin.register AdminUser do
  
  filter :email
  
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
    
    def new
      if AdminUser.true_admin? current_admin_user.email 
        super
      else
        flash[:alert] = "Warning: You don't have enough privilege to create another admin"
        render :index
      end
    end
    
    def show
      if AdminUser.true_admin? current_admin_user.email 
        super
      else
        flash[:alert] = "Warning: You don't have enough privilege to view other admin"
        render :index
      end
    end
    
    def update
      if AdminUser.true_admin? current_admin_user.email 
        super
      else
        flash[:alert] = "Warning: You don't have enough privilege to update this page"
        render :index
      end
    end
    
    def edit
      if AdminUser.true_admin? current_admin_user.email 
        super
      else
        flash[:alert] = "Warning: You don't have enough privilege to edit another admin"
        render :index
      end
    end
  end
  
end                                   
