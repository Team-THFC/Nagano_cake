class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller?



  def after_sign_in_path_for(resource)
      if member_signed_in?
        public_root_path
      else
        admin_root_path
      end
  end

  def after_sign_out_path_for(resource)
    public_root_path
  end


  protected

  def configure_permitted_parameters

     devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number,:password])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email,:password])
  end

  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code, :address, :phone_number,:email])
  end


end

