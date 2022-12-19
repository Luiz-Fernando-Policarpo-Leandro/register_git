class MailerVerificacaoDeEmailMailer < ApplicationMailer
    def mailer_senha_de_verificacao(user)
        @user_mailer = user
        mail(to: @user_mailer.usuario.email, subject: "Sua senha para a verificação de email")
    end
end