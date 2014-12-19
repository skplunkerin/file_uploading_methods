class S3Client
  require 's3'

  def self.upload(credentials,local_path,filename)
    p 'S3 UPLOAD'
    connect(credentials)
    file = @bucket.objects.build("#{credentials.aws_directory_path}#{filename}")
    file.content = open("#{local_path}#{filename}")
    file.save
  end

  def self.download(credentials,local_path,filename)
    p 'S3 DOWNLOAD'
    connect(credentials)
    file = @bucket.objects.find("#{credentials.aws_directory_path}#{filename}")
    File.open("#{local_path}#{filename}", 'w') do |f| 
      f.write("#{file.content(true)}")
    end
  end

  private
  def self.connect(credentials)
    p 'ESTABLISH S3 CONNECTION'
    s3 = S3::Service.new(
      :access_key_id      => Cryption.de_b64(credentials.aws_access_key_id), 
      :secret_access_key  => Cryption.de_b64(credentials.aws_secret_access_key)
    )
    @bucket = s3.buckets.find(credentials.aws_bucket)
  end
end
