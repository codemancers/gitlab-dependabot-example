class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :provider
      t.string :gid
      t.text :bio
      t.string :email
      t.string :fullname
      t.string :handle
      t.string :picture
      t.string :access_token

      t.timestamps
    end
  end
end
