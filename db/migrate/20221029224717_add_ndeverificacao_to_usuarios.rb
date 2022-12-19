class AddNdeverificacaoToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :ndeverificacao, :string
    add_column :usuarios, :status_usuario, :string
  end
end
