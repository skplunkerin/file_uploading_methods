class S3
  require 'aws/s3'

  def self.upload(credentials,local_path,filename)
    p 'S3 UPLOAD'
    connect(credentials)
    AWS::S3::S3Object.store("#{credentials.aws_directory_path}#{filename}",open("#{local_path}#{filename}"),credentials.aws_bucket)
  end

  def self.download(credentials,local_path,filename)
    p 'S3 DOWNLOAD'
    connect(credentials)
  end

  private
  def self.connect(credentials)
    p 'ESTABLISH S3 CONNECTION'
    AWS::S3::Base.establish_connection!(
      :access_key_id     => Cryption.de_b64(credentials.aws_access_key_id), 
      :secret_access_key => Cryption.de_b64(credentials.aws_secret_access_key)
    )
    # @bucket = Bucket.find(credentials.aws_bucket)
  end
end
