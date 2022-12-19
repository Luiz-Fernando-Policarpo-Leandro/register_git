class ApplicationController < ActionController::Base
    before_action :verificar_cookie_login
  
    def verificar_cookie_login
      if cookies[:log_user].blank?
        return redirect_to root_path
      end
      
      if verificar_veracidade_cookie_login.blank?
        cookies.delete :log_user
        return redirect_to root_path
      end   
    end

    def verificar_veracidade_cookie_login
        if cookies[:log_user].present?
          return @user if @user.present?
          @user = Usuario.find(JSON.parse(cookies[:log_user])["id"])
          return redirect_to '/aviso' if @user.status_usuario != "ativo"
          return @user
        end
        rescue
        nil
    end
    
end
