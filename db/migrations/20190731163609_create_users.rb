Hanami::Model.migration do
  change do
    alter_table :users do
      add_column :uuid, default: Hanami::Model::Sql.function(:uuid_generate_v4)
    end
  end
end
