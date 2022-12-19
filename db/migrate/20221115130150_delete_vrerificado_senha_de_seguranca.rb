class DeleteVrerificadoSenhaDeSeguranca < ActiveRecord::Migration[7.0]
  def change
    remove_column :senha_de_segurancas, :verificado
  end
end
