class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|

      t.integer :organisation_id, :null => false
      t.string :content, :null => false
      t.integer :creator_id
      t.timestamps
    end
  end
end
