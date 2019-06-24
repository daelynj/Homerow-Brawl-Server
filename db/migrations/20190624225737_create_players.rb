Hanami::Model.migration do
  change do
    create_table :players do
      primary_key :id

      column :player_id, Integer
    end
  end
end
