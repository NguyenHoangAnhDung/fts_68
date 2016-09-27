class CreateResultsAnswers < ActiveRecord::Migration
  def change
    create_table :results_answers do |t|
      t.text :answer_for_text
      t.references :result, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
