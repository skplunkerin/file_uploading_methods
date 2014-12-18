class Ftps
  require 'double_bag_ftps'

  def self.upload(credentials,file)
    p 'FTPS UPLOAD'
    connect(credentials)
    @ftps.chdir("#{credentials.directory_path}")
    @ftps.putbinaryfile(file)
    close_connection()
  end

  def self.download(credentials,path,filename)
    p 'FTPS DOWNLOAD'
    connect(credentials)
    @ftps.chdir("#{credentials.directory_path}")
    @ftps.getbinaryfile(filename,"#{path}#{filename}")
    close_connection()
  end

  private
  def self.connect(credentials)
    p 'ESTABLISH FTPS CONNECTION'
    host = credentials.host
    port = credentials.port
    username = credentials.user
    password = Cryption.de_b64(credentials.password)
    
    # Connect to a host using explicit FTPS and do not verify the host's cert
    @ftps = DoubleBagFTPS.new
    @ftps.ssl_context = DoubleBagFTPS.create_ssl_context(:verify_mode => OpenSSL::SSL::VERIFY_NONE)
    @ftps.debug_mode = true
    @ftps.passive = true
    @ftps.connect(host, port)
    @ftps.login(username, password)
  end

  def self.close_connection
    p 'CLOSE FTPS CONNECTION'
    @ftps.close
  end
end
