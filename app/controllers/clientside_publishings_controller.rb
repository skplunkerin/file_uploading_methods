class ClientsidePublishingsController < ApplicationController
  before_filter   :get_clientside_settings, :except => [:new, :create, :show]

  def index
  end

  def new
    @client_settings = ClientsidePublishing.new
    @upload_options = [ ['Upload Method', '0'],['FTP','FTP'],['FTPS','FTPS'],['S3','S3'] ]
  end

  def create
    # TODO:
    # 1. add form submission to database
    # 2. test saving something to the location
    #     a. test in this order: FTP, FTPS, S3
    @client_settings = ClientsidePublishing.create(post_params)
    raise @client_settings.to_yaml
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
