class AddNamespacePathToRepositories < ActiveRecord::Migration[6.0]
  def change
    add_column :repositories, :namespace_path, :string
  end
end
