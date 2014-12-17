class Cryption
  def self.en_b64(s)
    if s
      return AES.encrypt(s, APP_CONFIG['aes']['key'])
    end
  end

  def self.de_b64(s)
    if s
      return AES.decrypt(s,APP_CONFIG['aes']['key'])
    end
  end
end
