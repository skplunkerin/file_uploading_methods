class ClientsidePublishingsController < ApplicationController
  before_filter   :get_clientside_settings, :except => [:new, :create, :show]

  def index
  end

  def new
    @client_settings = ClientsidePublishing.new
    @upload_options = [ ['Upload Method', '0'],['FTP','FTP'],['SFTP','SFTP'],['SCP','SCP'],['S3','S3'] ]
  end

  def create
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
end
