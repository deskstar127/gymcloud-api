class CreateLoggedStripeEvents < ActiveRecord::Migration
  def change
    create_table :logged_stripe_events do |t|
      t.text :data
      t.string :stripe_event_id

      t.timestamps null: false
    end
    add_index :logged_stripe_events, :stripe_event_id
  end
end
