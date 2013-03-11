class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :qn
      t.string :correct
      t.string :option1
      t.string :option2
      t.string :option3
      t.string :category

      t.timestamps
    end
  end
end
