class CreateCrawlers < ActiveRecord::Migration
  def change
    create_table :crawlers do |t|
      t.text :configuration, :null => false, limit: 64.kilobytes #8320 char
      t.references :user, :null => false
      t.timestamps
    end
  end
end
