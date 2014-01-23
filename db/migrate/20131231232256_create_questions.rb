class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|

      t.integer :creator_id, :null => false
      t.integer :organisation_id, :null => false
      t.string :title, :null => false
      t.string :content, :null => false
      t.timestamps
    end
  end
end
