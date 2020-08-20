class CreateUpdatedPackages < ActiveRecord::Migration[6.0]
  def change
    create_table :updated_packages do |t|
      t.belongs_to :repository
      t.string :name
      t.string :package_manager
      t.string :previous_version
      t.string :current_version

      t.timestamps
    end
  end
end
