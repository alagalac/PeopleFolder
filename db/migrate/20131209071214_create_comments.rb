class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.string   :entity_type, :null => false
      t.integer  :entity_id, :null => false
      t.integer  :creator_id, :null => false
      t.string   :content, :null => false
      t.integer  :organisation_id, :null => false
      t.timestamps
    end
  end
end
