class CreateFunFacts < ActiveRecord::Migration
  def change
    create_table :fun_facts do |t|
      t.text :text, null: false
      t.timestamps null: false
    end

    add_reference :fun_facts, :user, null: false
  end
end
