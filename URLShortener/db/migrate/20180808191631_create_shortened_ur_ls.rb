class CreateShortenedUrLs < ActiveRecord::Migration[5.2]
  def change
    create_table :shortened_urls do |t|
      t.integer :user_id
      t.string :long_url
      t.string :short_url
      t.string :email
    end
    add_index :shortened_urls, :short_url
    add_index :shortened_urls, :email
  end
end
