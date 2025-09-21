class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments, id: :uuid do |t|
      t.references :song, null: false, foreign_key: true, type: :uuid
      t.text :contents

      t.timestamps
    end
  end
end
