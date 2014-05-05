class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :job_id
      t.string :state
      t.datetime :status_time
      t.text :notes

      t.timestamps
    end
  end
end
