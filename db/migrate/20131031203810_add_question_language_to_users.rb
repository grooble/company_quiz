class AddQuestionLanguageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :question_language, :string
  end
end
