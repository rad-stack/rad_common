class AddChunkIndexToEmbeddings < ActiveRecord::Migration[7.2]
  def change
    add_column :embeddings, :chunk_index, :integer, null: false, default: 0

    remove_index :embeddings, [:embeddable_type, :embeddable_id]
    add_index :embeddings, %i[embeddable_type embeddable_id chunk_index], unique: true,
                                                                          name: 'index_embeddings_on_type_id_and_chunk'
  end
end
