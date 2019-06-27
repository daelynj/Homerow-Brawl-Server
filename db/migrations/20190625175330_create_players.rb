Hanami::Model.migration do
  change do
    create_table :players do
      primary_key :id
    end
  end
end
