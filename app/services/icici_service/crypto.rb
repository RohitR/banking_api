module IciciService
  class Crypto

    PRIVATE_KEY_PATH = '/Users/Rohith/Documents/keys/priv.pem'
    ICCI_CERTIFICATE_FILE_PATH = ''
    SPP_CERTIFICATE_FILE_PATH = '/Users/Rohith/Documents/keys/cert.pem'

    def initialize(params)
      @params = params
    end

    def decrypt
      JSON.parse(private_key.private_decrypt(decode_base64))
    end

    def encrypt_for_icici
      pub_key = public_key(ICCI_CERTIFICATE_FILE_PATH)
      encrypt(pub_key)
    end

    def encrypt_for_spp
      pub_key = public_key(SPP_CERTIFICATE_FILE_PATH)
      encrypt(pub_key)
    end

    private

    def encrypt(pub_key)
      encrypted_data = pub_key.public_encrypt(@params.to_json)
      encode_base64(encrypted_data)
    end

    def decode_base64
      Base64.decode64(@params)
    end

    def encode_base64(encrypted_data)
      Base64.encode64(encrypted_data)
    end

    def public_key(certificate_path)
      cert_file = File.read(certificate_path)
      OpenSSL::X509::Certificate.new(cert_file).public_key
    end

    def private_key
      OpenSSL::PKey::RSA.new(File.read(PRIVATE_KEY_PATH))
    end

    def pkcs5_encrypt
      cipher = OpenSSL::Cipher.new(CIPHER_AES_256)
      cipher.encrypt

      cipher.key = random_key
      cipher.iv = ''
      Base64.encode64(cipher.update(@params.to_json) + cipher.final)
    end

    def random_key
      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.random_key
    end
  end
end