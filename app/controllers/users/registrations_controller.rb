class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]

# Iter 1-2
helper_method :subscribed?

  def subscribed?
    not NewsletterUser.where("email = ?", resource.email).empty?
  end
# End for Iter 1-2

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  # def create
  #   build_resource(sign_up_params)
  #   resource.save
  #   yield resource if block_given?
  #   if resource.persisted?
  #     if resource.active_for_authentication?
  #       set_flash_message :notice, :signed_up if is_flashing_format?
  #       sign_up(resource_name, resource)
  #       respond_with resource, location: after_sign_up_path_for(resource)
  #     else
  #       set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
  #       expire_data_after_sign_in!
  #       respond_with resource, location: after_inactive_sign_up_path_for(resource)
  #     end
  #     if params[:subscribe_newsletter].present?
  #       NewsletterUser.find_or_create_by(email: resource.email)
  #     end
  #   else
  #     clean_up_passwords resource
  #     set_minimum_password_length
  #     respond_with resource
  #   end
  # end
  def create
    # build_resource(sign_up_params)
    # resource.save
    @user = User.new(sign_up_params)
    p "*"*80
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
 
  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  # Iter 1-2
  def update
    super
    
    user = User.find_by_email(params[:user][:email])
    
    if params[:subscribe_newsletter].present? and user.valid_password?(params[:user][:current_password])
      NewsletterUser.find_or_create_by(email: resource.email)
    elsif params[:unsubscribe_newsletter].present? and user.valid_password?(params[:user][:current_password])
      NewsletterUser.where(email: resource.email).destroy_all
    end
  end
  # End for Iter 1-2

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << [:attribute, :username]
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :attribute
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
  
end
