Hanami::Model.migration do
  change do
    alter_table :player_rooms do
      add_column :created_at, DateTime, null: false
      add_column :updated_at, DateTime, null: false
      add_column :words_typed, Integer
      add_column :time, Integer
      add_column :mistakes, Integer
      add_column :letters_typed, Integer
    end
  end
end
