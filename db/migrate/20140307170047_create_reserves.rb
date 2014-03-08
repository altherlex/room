class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.datetime :date
      #t.int :user_id 
      t.references :user
      #t.integer :posts, :user_id, :integer
      #add_reference :levels, :student, index: true

      t.timestamps
    end
  end
end
