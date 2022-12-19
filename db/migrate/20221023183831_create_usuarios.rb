class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :sobrenome
      t.boolean :telefone
      t.string :email
      t.string :senha
      t.boolean :status_adm

      t.timestamps
    end
  end
end
