class RemoveEmbeddingMetadata < ActiveRecord::Migration[7.2]
  def change
    remove_column :embeddings, :metadata
  end
end
