class CreateAnnouncements < ActiveRecord::Migration[5.1]
  def change
    create_table :announcements do |t|
      t.references :admin, foreign_key: true
      t.string :subject
      t.string :content

      t.timestamps
    end
  end
end
