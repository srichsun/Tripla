class CreateTrackings < ActiveRecord::Migration[6.1]
  def change
    create_table :trackings do |t|
      t.string :duration
      t.integer :user_id

      t.timestamps
    end
  end
end
