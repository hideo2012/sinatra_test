class Messages < ActiveRecord::Migration[7.2]
  def change
    create_table :messages  do |t|
      t.string :name 
      t.string :comment
    end
  end
end

