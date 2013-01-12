class CreateBeans < ActiveRecord::Migration
  def change
    create_table :beans do |t|
      t.string      :code, :null => false 
      t.integer     :token_id, :null => false 
      t.string      :used_on, :default => 'none' 
      t.boolean     :is_checkout, :default => false
      t.timestamps
    end

    add_index :beans, :token_id 
    add_index :beans, :code
    add_index :beans, :used_on
  end
end
