class Ftp
  require 'net/ftp'

  def self.upload(credentials,file)
    p 'FTP UPLOAD'
    connect(credentials)
    @ftp.chdir("#{credentials.directory_path}")
    @ftp.putbinaryfile(file)
    close_connection()
  end

  def self.download(credentials,path,filename)
    p 'FTP DOWNLOAD'
    connect(credentials)
    @ftp.chdir("#{credentials.directory_path}")
    @ftp.getbinaryfile(filename,"#{path}#{filename}")
    close_connection()
  end

  private
  def self.connect(credentials)
    p 'ESTABLISH FTP CONNECTION'
    host = credentials.host
    port = credentials.port
    username = credentials.user
    password = Cryption.de_b64(credentials.password)
    
    @ftp = Net::FTP.new
    @ftp.debug_mode = true
    @ftp.passive = true
    @ftp.connect(host,port)
    @ftp.login(username, password)
  end

  def self.close_connection
    p 'CLOSE FTP CONNECTION'
    @ftp.close
  end
end
