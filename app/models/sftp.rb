class Sftp
  require 'net/ssh'
  require 'net/sftp'

  def self.upload(credentials,local_path,filename)
    p 'SFTP UPLOAD'
    connect(credentials)
    @sftp.upload!("#{local_path}#{filename}","#{credentials.directory_path}#{filename}")
  end

  def self.download(credentials,local_path,filename)
    p 'SFTP DOWNLOAD'
    connect(credentials)
    @sftp.download!("#{credentials.directory_path}#{filename}","#{local_path}#{filename}")
  end

  private
  def self.connect(credentials)
    p 'ESTABLISH SFTP CONNECTION'
    host = credentials.host
    username = credentials.user
    password = Cryption.de_b64(credentials.password)
    port = credentials.port

    session = Net::SSH.start(host, username, :password => password, :port => port)
    @sftp = Net::SFTP::Session.new(session).connect!
  end
end
