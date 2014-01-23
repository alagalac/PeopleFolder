class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name, :null => false
      t.integer :organisation_id, :null => false
      t.string :title, :null => false
      t.string :content
      t.timestamps
    end

    add_index :pages, [:organisation_id, :name], :unique => true
  end
end
