class CreateEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :entries do |t|
      t.datetime  :entry_at, null: false
      t.text  :meal, default: nil
      t.references :subject, default: nil
      t.references :hunger_level, default: nil
      t.references :energy_level, default: nil
      t.references :concentration_level, default: nil
      t.references :mood, default: nil
      t.text  :physiological_reaction, default: nil
      t.text  :notes, default: nil
      t.timestamps
    end
  end
end
