def destroy_user(id)
  if AdminUser.true_admin? current_admin_user.id 
    if current_admin_user.id.to_s == id.to_s
      flash[:alert] = "Warning: Site owner can not be deleted"
    else
      adm = AdminUser.find(id)
      adm.destroy
    end
  else
    flash[:alert] = selget_warning + " delete"
  end
end
ActiveAdmin.register AdminUser do
  
  menu :priority => 14
  
  filter :email

  batch_action :destroy, confirm: "Are you sure you want to delete these users?" do |ids|
    ids.each do |i|
      destroy_user(i)
    end
    redirect_to admin_dogs_path
  end
  
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
      destroy_user(params[:id])
      redirect_to admin_users_path
    end
    
    def new
      if AdminUser.true_admin? current_admin_user.id 
        super
      else
        flash[:alert] = AdminUser.get_warning + " create"
        redirect_to admin_users_path
      end
    end
    
    def show
      if AdminUser.has_permission?(current_admin_user.id, params[:id])
        super
      else
        flash[:alert] = AdminUser.get_warning + " view"
        redirect_to admin_users_path
      end
    end
    
    def update
      if AdminUser.has_permission?(current_admin_user.id, params[:id])
        super
      else
        flash[:alert] = AdminUser.get_warning + " update"
        redirect_to admin_users_path
      end
    end
    
    def edit
      if AdminUser.has_permission?(current_admin_user.id, params[:id])
        super
      else
        flash[:alert] = AdminUser.get_warning + " edit"
        redirect_to admin_users_path
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
