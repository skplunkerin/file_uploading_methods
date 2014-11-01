class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.references        :user

      t.boolean            :client_publishing, :default => false

      t.timestamps
    end
  end
end
