class Books < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :bookname
    end
  end
end
