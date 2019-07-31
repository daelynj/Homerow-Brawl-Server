Hanami::Model.migration do
  change do
    alter_table :players do
      rename_column :user_id, :player_id
    end
  end
end
