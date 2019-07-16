Hanami::Model.migration do
  change do
    create_table :rooms do
      primary_key :id
    end
  end
end
