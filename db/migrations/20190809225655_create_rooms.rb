Hanami::Model.migration do
  change do
    alter_table :rooms do
      add_column :created_at, DateTime, null: false
      add_column :updated_at, DateTime, null: false
      add_column :game_started, :boolean, default: false

      drop_column :players
    end
  end
end
