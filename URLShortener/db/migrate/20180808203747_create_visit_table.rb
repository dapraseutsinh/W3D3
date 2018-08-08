class CreateVisitTable < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.integer :visitor_user_id
      t.string :visited_url
      t.timestamps
    end
  end
end
