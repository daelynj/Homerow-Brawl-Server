Hanami::Model.migration do
  change do
    alter_table :users do
      column :uuid, default: Hanami::Model::Sql.function(:uuid_generate_v4)
    end
  end
end
