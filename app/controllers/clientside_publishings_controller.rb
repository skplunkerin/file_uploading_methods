class ClientsidePublishingsController < ApplicationController
  before_filter   :get_clientside_settings, :except => [:new, :create, :show, :test_ftp, :test_sftp, :test_ftps, :test_scp]

  def index
  end

  def new
    @client_settings = ClientsidePublishing.new
    @upload_options = [ ['Upload Method', '0'],['FTP','FTP'],['FTPS','FTPS'],['SFTP','SFTP'],['SCP','SCP'],['S3','S3'] ]
  end

  def create
    @client_settings = ClientsidePublishing.new(post_params)
    @client_settings.profile_id = @current_user.id
    if @client_settings.save
      redirect_to root_path
    end
  end

  def test_ftp
    # Grab FTP settings for current user, if none redirect back to profile
    @client_settings = ClientsidePublishing.where(:profile_id => @current_user.id,:method => 'FTP').first
    if @client_settings.nil?
      flash[:error] = 'No FTP settings for this user, unable to test'
      redirect_to profile_client_publishes_path(@current_user.id)
    else
      p 'Test uploading file'
      Ftp.upload(@client_settings,"#{Rails.root}/publish/test.json")

      # p 'Test downloading file'
      # path = "#{Rails.root}/publish/"
      # filename = 'testing_download.json'
      # Ftp.download(@client_settings,path,filename)
      throw 'done! :D'
    end
  end

  def test_ftps
    # Grab FTPS settings for current user, if none redirect back to profile
    @client_settings = ClientsidePublishing.where(:profile_id => @current_user.id,:method => 'FTPS').first
    if @client_settings.nil?
      flash[:error] = 'No FTPS settings for this user, unable to test'
      redirect_to profile_client_publishes_path(@current_user.id)
    else
      p 'Test uploading file'
      # Ftps.upload(@client_settings,"#{Rails.root}/publish/test_ftps_upload.json")

      # p 'Test downloading file'
      path = "#{Rails.root}/publish/"
      filename = 'testing_ftps_download.json'
      Ftps.download(@client_settings,path,filename)
      throw 'done! :D'
    end
  end

  def test_sftp
    # Grab SFTP settings for current user, if none redirect back to profile
    @client_settings = ClientsidePublishing.where(:profile_id => @current_user.id,:method => 'SFTP').first
    if @client_settings.nil?
      flash[:error] = 'No FTPS settings for this user, unable to test'
      redirect_to profile_client_publishes_path(@current_user.id)
    else
      # p 'Test uploading file'
      # Sftp.upload(@client_settings,"#{Rails.root}/publish/","test_sftp_upload.json")

      p 'Test downloading file'
      Sftp.download(@client_settings,"#{Rails.root}/publish/","testing_sftp_download.json")
      throw 'done! :D'
    end
  end

  def test_scp
    # Grab SCP settings for current user, if none redirect back to profile
    @client_settings = ClientsidePublishing.where(:profile_id => @current_user.id,:method => 'SCP').first
    if @client_settings.nil?
      flash[:error] = 'No FTPS settings for this user, unable to test'
      redirect_to profile_client_publishes_path(@current_user.id)
    else
      # p 'Test uploading file'
      # Scp.upload(@client_settings,"#{Rails.root}/publish/","test_scp_upload.json")

      p 'Test downloading file'
      Scp.download(@client_settings,"#{Rails.root}/publish/","testing_scp_download.json")
      throw 'done! :D'
    end
  end

  def test_s3
    # TODO
    # Grab S3 settings for current user, if none redirect back to profile
    @client_settings = ClientsidePublishing.where(:profile_id => @current_user.id,:method => 'S3').first
    if @client_settings.nil?
      flash[:error] = 'No FTPS settings for this user, unable to test'
      redirect_to profile_client_publishes_path(@current_user.id)
    else
      local_path = "#{Rails.root}/publish/"
      p 'Test uploading file'
      S3.upload(@client_settings,local_path,"test_s3_upload.json")

      # p 'Test downloading file'
      # S3.download(@client_settings,local_path,"testing_s3_download.json")
      throw 'done! :D'
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private
  def get_clientside_settings
    @client_settings = ClientsidePublishing.find_by_profile_id( @current_user.profile.id )
    p 'CURRENT CLIENT SETTINGS'
    p @client_settings
  end

  def post_params
    params.require(:clientside_publishing).permit(:method,:host,:user,:password,:directory_path,:port,:aws_access_key_id,:aws_secret_access_key,:aws_bucket,:aws_directory_path)
  end
end
