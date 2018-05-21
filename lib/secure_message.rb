require 'base64'
require 'rbnacl/libsodium'

class SecureMessage 

    def self.encoded_random_bytes(length)
        bytes = RbNaCl::Random.random_bytes(length)
        Base64.strict_encode64 bytes
    end

    def self.generate_key
        encoded_random_bytes(RbNaCl::SecretBox.key_bytes)
    end

    def self.setup(config)
        @config = config
    end

    def self.key
        @key ||= Base64.strict_decode64(@config.MSG_KEY)
    end

    def self.encrypt(message)
        return nil unless message
        message_json = message.to_json
        simple_box = RbNaCl::SimpleBox.from_secret_key(key)
        ciphertext = simple_box.encrypt(message_json)
        Base64.urlsafe_encode64(ciphertext)
    end

    def self.decrypt(ciphertext64)
        return nil unless ciphertext64
        ciphertext = Base64.urlsafe_decode64(ciphertext)
        simple_box = RbNaCl::SimpleBox.from_secret_key(key)
        message_json = simple_box.decrypt(ciphertext)
        JSON.parse message_json 
    end

end