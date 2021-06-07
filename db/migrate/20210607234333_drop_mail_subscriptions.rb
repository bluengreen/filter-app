class DropMailSubscriptions < ActiveRecord::Migration[6.0]
  def change
    drop_table :mail_subscription_histories
    drop_table :mail_subscriptions
  end
end
