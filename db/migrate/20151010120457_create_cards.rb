class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :fun_fact_ids, array: true, default: []
      t.timestamps null: false
    end

    add_index :cards, :fun_fact_ids, unique: true
  end
end
