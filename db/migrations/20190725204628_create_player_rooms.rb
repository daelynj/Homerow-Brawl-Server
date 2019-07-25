Hanami::Model.migration do
  change do
    create_table :player_rooms do
      primary_key :id
      foreign_key :player_id, :players
      foreign_key :room_id, :rooms
      column :position, Integer, null: false, default: 0

      constraint(:position_constraint) { position >= 0 && position <= 100 }

      index %i[player_id room_id], unique: true
    end
  end
end
