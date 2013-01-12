class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string    :code,        :null => false 
      t.integer   :merchant_id, :null => false     
      t.timestamps
    end

    add_index :tokens, :code 
    add_index :tokens, :merchant_id
    add_index :tokens, [:merchant_id, :code]
  end
end
