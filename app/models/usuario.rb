class Usuario < ApplicationRecord
    enum :status_usuario, [:aguardando ,:ativo ,:bloqueado]
    validates :email,
            presence: true,
            uniqueness: true,
            format: { with: /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/ }
    
    validates :senha, presence: true, format: {with: /\A(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}\z/}
end
