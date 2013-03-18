class CreateTakens < ActiveRecord::Migration
  def change
    create_table :takens do |t|
      t.integer :user_id
      t.integer :question_id
      t.boolean :correct

      t.timestamps
    end
	
	add_index :takens, :user_id
  end
end
