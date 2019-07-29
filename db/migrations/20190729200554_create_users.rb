Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      column :user_id, String, null: false, unique: true
      column :name, String, null: false
      column :team_id, String, null: false
      column :access_token, String, null: false, unique: true
    end
  end
end
