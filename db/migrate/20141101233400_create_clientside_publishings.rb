class CreateClientsidePublishings < ActiveRecord::Migration
  def change
    create_table :clientside_publishings do |t|
      t.references          :profile

      # SFTP/FTP & SCP
      t.string              :method
      t.string              :host
      t.string              :username
      t.string              :password
      t.string              :directory_path
      t.integer             :port

      # AWS S3
      t.string              :aws_access_key_id
      t.string              :aws_secret_access_key
      t.string              :aws_bucket
      t.string              :aws_directory_path

      t.timestamps
    end

    add_index( :clientside_publishings, :profile_id )
  end
end
