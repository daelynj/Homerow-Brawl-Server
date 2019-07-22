Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :players do
      primary_key :id
      column :token,
             'uuid',
             default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :room, Integer
      column :position, Integer
    end
  end

  down do
    drop_table :players
    execute 'DROP EXTENSION IF EXISTS "uuid-ossp"'
  end
end
