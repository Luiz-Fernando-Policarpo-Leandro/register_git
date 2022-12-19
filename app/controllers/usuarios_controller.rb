class UsuariosController < ApplicationController
  skip_before_action :verificar_cookie_login, only: [:logout ,:login, :index, :cadastro, :cadastro_registro,:aviso , :send_email]
  
  def index
    return redirect_to "/home" if verificar_veracidade_cookie_login != nil
  end

  


  def login
    if verify_recaptcha
      usuario_login = Usuario.where(email: params[:email], senha: params[:senha])
      usuario_login = usuario_login.first
      if pivado_user_login_cookies(usuario_login) != nil
      else
        flash[:erro] = "Email ou senha invalidos"
      end
    else
      flash[:erro] = "coloque o recaptcha"
    end
    redirect_to 
  end




  def logout
    cookies.delete :log_user
    redirect_to '/home'
  end




  def home;end
  



  def cadastro
    return redirect_to "/home" if verificar_veracidade_cookie_login != nil
    if params[:email_cad].present?
      cadastro = Usuario.new(nome: params[:nome_cad],email: params[:email_cad] , senha: params[:senha_cad], status_usuario: 'aguardando')
      
      flash[:error] = []
      flash[:error] << "Esse nome ja existe" if Usuario.find_by_nome(params[:nome_cad]).present?
      flash[:error] << "Email ja existe" if Usuario.find_by_email(params[:email_cad]).present?
      flash[:error] << "Email inavlido" if cadastro.valid?(:email) == false && flash[:error][1].nil?
      flash[:error] << "senha invalida" if /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}\z/.match?(cadastro.senha) == false
      if flash[:error].empty?
        cadastro.save!
        printar("salvo o cadastro")
        pivado_user_login_cookies(cadastro)
        send_email(true)
        return redirect_to "/aviso"
      end
    redirect_to "/cadastro"
    end
  end
  


  
  def send_email(passive=nil)
      user = Usuario.find(JSON.parse(cookies[:log_user])["id"])
      user_senha_seguranca = SenhaDeSeguranca.find_by_usuario_id(user.id)
      #user_senha_seguranca.destroy if user_senha_seguranca.present? 
    if params[:email_aviso].nil?
      if user_senha_seguranca.blank? 
        senha_aleatoria = (('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a).to_a.shuffle.first(6).join
        user_novo = SenhaDeSeguranca.new(usuario_id: user.id,senha: senha_aleatoria)
        user_novo.save!
      end
      MailerVerificacaoDeEmailMailer.mailer_senha_de_verificacao(user_senha_seguranca).delivery_before
      flash[:error] = ["enviamos uma senha de verificação para o seu email:#{user['email']}"]
      return if passive.present?
    elsif params[:email_aviso].present? 
      if user_senha_seguranca.nil?
         flash[:error] = "desculpe houve algum erro, tente reenviar o email"
      elsif user_senha_seguranca.senha == params[:email_aviso]
        user.status_usuario = "ativo" if user.status_usuario != "bloqueado"
        user.save!
      else
        flash[:error] = "senha incorreta"
      end
    end
    redirect_to "/aviso"
  end




  def aviso
    if cookies[:log_user].present?
      status_user = Usuario.find(JSON.parse(cookies[:log_user])["id"]).status_usuario
      return render "aviso_contaaguarde" if status_user == 'aguardando'
      return render "aviso_contabloqueado" if status_user == 'bloqueado'
      return redirect_to "/home" if status_user == "ativo"
    else
      redirect_to "/"
    end
  end

private

  def pivado_user_login_cookies(user)
    if user.present?
      value = {id: user.id ,nome: user.nome,email: user.email,senha: user.senha}
      cookies[:log_user] = {value: value.to_json, expires: 1.year.from_now, httponly: true}
    else
      nil
    end
  end

  #def printar(texto);puts "\n\n\t\t#{texto}\n\n";end
end