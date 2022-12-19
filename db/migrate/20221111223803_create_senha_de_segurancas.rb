class CreateSenhaDeSegurancas < ActiveRecord::Migration[7.0]
  def change
    create_table :senha_de_segurancas do |t|
      t.references :usuario, null: false, foreign_key: true
      t.string :senha
      t.string :verificado

      t.timestamps
    end
  end
end
