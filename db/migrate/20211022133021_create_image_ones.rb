class CreateImageOnes < ActiveRecord::Migration[7.0]
  def change
    create_table :image_ones do |t|
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
