class CreateRepositories < ActiveRecord::Migration[6.0]
  def change
    create_table :repositories do |t|
      t.boolean :scan
      t.string :name
      t.string :description
      t.string :visibility
      t.integer :repo_id
      t.string :web_url
      t.references :user

      t.timestamps
    end
  end
end
