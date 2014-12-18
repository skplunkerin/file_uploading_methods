class Scp
  require 'net/ssh'
  require 'net/scp'

  def self.upload(credentials,local_path,filename)
    p 'SCP UPLOAD'
    connect(credentials)
    @ssh.scp.upload!("#{local_path}#{filename}","#{credentials.directory_path}#{filename}")
  end

  def self.download(credentials,local_path,filename)
    p 'SCP DOWNLOAD'
    connect(credentials)
    @ssh.scp.download!("#{credentials.directory_path}#{filename}","#{local_path}#{filename}")
  end

  private
  def self.connect(credentials)
    p 'ESTABLISH SCP CONNECTION'
    host = credentials.host
    username = credentials.user
    password = Cryption.de_b64(credentials.password)
    port = credentials.port

    @ssh = Net::SSH.start(host, username, :password => password, :port => port)
  end
end
