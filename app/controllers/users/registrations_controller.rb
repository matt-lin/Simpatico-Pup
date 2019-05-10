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

  def password_errors(temp)
    if params[:user][:password].empty?                 
      temp << 'Password can not be empty'
    end
    if params[:user][:password_confirmation].empty? 
      temp << 'Password confirmation can not be empty'
    end  
    if params[:user][:password].length<8
      temp << 'Password must contain more than 8 characters'
    end
    if params[:user][:password] != params[:user][:password_confirmation]
      temp << "Password not same as Confirmation"
    end
    if params[:user][:password] =~ /^\s*$/
      temp << 'Password can not contain whitespace'
    end
  end

  def email_errors(temp)
    if params[:user][:email].empty?
      temp << 'Email can not be empty'
    end
    if User.find_by_email(params[:user][:email])
      temp << 'Email has already been taken'
    end
  end

  def username_errors(temp)
    if params[:user][:username].empty?
      temp << "Username can not be empty"
    end
  end

  def set_error_message()
    temp = []

    password_errors(temp)
    email_errors(temp)
    username_errors(temp)

    if temp.length != 0
      flash[:notice] = "#{temp.length} errors prohibited this user from being saved:<br/>"
      temp.each_with_index do |msg, id|
        flash[:notice] += "&emsp;&#8226; " + msg 
      end
    end

    puts temp
  end

  def is_subscriber
    if params[:subscribe_newsletter].present?
      NewsletterUser.find_or_create_by(email: resource.email)
    end
  end

  # POST /resource
  def create
    set_error_message()

    puts '*'*80
    
    puts '*'*80
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :success, :signed_up if is_flashing_format?
        UserMailer.account_activation(@user).deliver_now
        flash[:success] += " Please check your email to activate your account."
        respond_with resource, location: after_sign_up_path_for(resource)
      end 
      is_subscriber()
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
 
  # GET /resource/edit
  def edit
    if current_user
      @username = current_user.username
    end
    super
  end

  # PUT /resource
  # Iter 1-2
  def update
    super
  end
  # End for Iter 1-2
  
  #Iter3-2 unsubscribe_newsletter (by Jeff Yu)
  def unsubscribe_newsletter
    NewsletterUser.where(email: params[:email]).destroy_all
    flash[:notice] = 'You have unsubscribed newsletter!'
    redirect_to root_path and return
  end
  #End for Iter3-2.
  
  def update_subscription
    if params[:to_subscribe] == "true"
      NewsletterUser.create(:email => current_user.email)
      flash[:notice] = 'You are subscribing newsletter now!'
    else
      NewsletterUser.where(:email => current_user.email).destroy_all
      flash[:notice] = 'You have unsubscribed newsletter!'
    end
    
    redirect_to edit_user_registration_path
  end

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
    devise_parameter_sanitizer.for(:sign_up) << [:attribute, :username, :activate, :activate_at, :authenticity_token]
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :attribute
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end
  
end
