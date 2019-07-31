Hanami::Model.migration do
  change do
    alter_table :players do
      add_column :created_at, DateTime, null: false
      add_column :updated_at, DateTime, null: false

      add_column :user_id, String, null: false, unique: true
      add_column :name, String, null: false
      add_column :team_id, String, null: false
      add_column :access_token, String, null: false, unique: true

      rename_column :token, :uuid
    end

    drop_table :users
  end
end
