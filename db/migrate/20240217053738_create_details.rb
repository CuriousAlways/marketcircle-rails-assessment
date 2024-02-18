class CreateDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :details do |t|
      t.string :title
      t.integer :age
      t.string :phone
      t.string :email
      t.references :person, foreign_key: { to_table: :people }, index: { unique: true }

      t.timestamps
    end
  end
end
