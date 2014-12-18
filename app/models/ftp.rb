class Ftp
  require 'net/ftp'

  def self.upload(credentials,file)
    p 'FTP UPLOAD FILE'
    # Connect
    make_connection(credentials)
    @ftp.chdir("#{credentials.directory_path}")
    @ftp.putbinaryfile(file)

    # Close connection
    close_connection
  end

  def self.download(credentials,path,filename)
    p 'FTP DOWNLOAD FILE'
    # Connect
    make_connection(credentials)
    @ftp.chdir("#{credentials.directory_path}")
    @ftp.getbinaryfile(filename,"#{path}#{filename}")

    # Close connection
    close_connection
  end

  private
  def self.make_connection(credentials)
    # Make connection
    host = credentials.host
    port = credentials.port
    username = credentials.user
    password = Cryption.de_b64(credentials.password)
    
    p 'how we doin?'
    p host
    p port
    p username

    @ftp = Net::FTP.new
    @ftp.debug_mode = true
    @ftp.passive = true
    @ftp.connect(host,port)
    @ftp.login(username, password)
  end

  def self.close_connection
    p 'close ftp connection'
    # Close connection
    @ftp.close
  end
end
