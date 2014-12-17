class ClientsidePublishing < ActiveRecord::Base
  belongs_to        :profile
  before_save       :encrypt_data

  private
  def encrypt_data
    if password.present?
      self.password = Cryption.en_b64(password)
    end
    if aws_secret_access_key.present?
      self.aws_secret_access_key = Cryption.en_b64(aws_secret_access_key)
    end
  end
end
