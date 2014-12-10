class ClientsidePublishing < ActiveRecord::Base
  belongs_to        :profile
  before_save       :encrypt_password

  def encrypt_password
    if password.present?
      salt = 'ab12cd34asd;lfjklkkjkasjie10294lkj32r9ujv'
      self.password = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
