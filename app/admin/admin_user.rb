ActiveAdmin.register AdminUser do
  
  menu :priority => 13
  
  filter :email
  
  index do            
    selectable_column if AdminUser.true_admin? current_admin_user.id 
    column :email
    column :owner do |a|
      AdminUser.true_admin? a.id
    end
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count   
    actions if AdminUser.true_admin? current_admin_user.id 
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
      if AdminUser.true_admin? current_admin_user.id 
        if current_admin_user.id.to_s == params[:id].to_s
          flash[:alert] = "Warning: Site owner can not be deleted"
          redirect_to "/admin/admin_users/"
        else
          super
        end
      else
        flash[:alert] = selget_warning + " delete"
        redirect_to "/admin/admin_users/"
      end
    end
    
    def new
      if AdminUser.true_admin? current_admin_user.id 
        super
      else
        flash[:alert] = AdminUser.get_warning + " create"
        redirect_to "/admin/admin_users/"
      end
    end
    
    def show
      if AdminUser.has_permission?(current_admin_user.id, params[:id])
        super
      else
        flash[:alert] = AdminUser.get_warning + " view"
        redirect_to "/admin/admin_users/"
      end
    end
    
    def update
      if AdminUser.has_permission?(current_admin_user.id, params[:id])
        super
      else
        flash[:alert] = AdminUser.get_warning + " update"
        redirect_to "/admin/admin_users/"
      end
    end
    
    def edit
      if AdminUser.has_permission?(current_admin_user.id, params[:id])
        super
      else
        flash[:alert] = AdminUser.get_warning + " edit"
        redirect_to "/admin/admin_users/"
      end
    end
  end
  
  def AdminUser.get_warning 
    "Warning: You don't have enough privilege to perform operation:"
  end
  
  def AdminUser.has_permission?(curr, prev)
    AdminUser.true_admin? curr or curr.to_s == prev.to_s
  end
  
end                                   
