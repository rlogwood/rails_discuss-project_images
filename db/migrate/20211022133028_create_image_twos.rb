class CreateImageTwos < ActiveRecord::Migration[7.0]
  def change
    create_table :image_twos do |t|
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
