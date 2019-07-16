Hanami::Model.migration do
  change do
    create_table :rooms do
      primary_key :id
      column :players, Integer
    end
  end
end
