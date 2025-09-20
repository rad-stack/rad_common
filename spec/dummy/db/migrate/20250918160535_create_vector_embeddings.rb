class CreateVectorEmbeddings < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'vector'

    create_table :embeddings do |t|
      t.string :embeddable_type, null: false
      t.bigint :embeddable_id, null: false
      t.vector :embedding, limit: 1536, null: false
      t.jsonb :metadata, null: false, default: {}

      t.timestamps
    end

    add_index :embeddings, [:embeddable_type, :embeddable_id], unique: true
    add_index :embeddings, :metadata, using: :gin
    add_index :embeddings, :embedding, using: :hnsw, opclass: :vector_cosine_ops
  end
end
