class CreateProdutos < ActiveRecord::Migration[7.0]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.string :descricao
      t.integer :preco
      t.integer :tamanho
      t.date :prazo

      t.timestamps
    end
  end
end
