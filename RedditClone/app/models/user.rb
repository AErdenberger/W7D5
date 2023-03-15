class User < ApplicationRecord
    before_validation :ensure_session_token

    validates :username, presence: true, uniqueness: true
    validates :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length:{minimum:6}, allow_nil: true

    attr_reader :password

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            return @user
        else
            return nil 
        end

    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def is_password?(password)
        bcrypt_object = BCrypt::Password.new(self.password_digest)
        bcrypt_object.is_password?(password)
    end

    def reset_session_token!
        self.session_token = generate_session_token
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= generate_session_token
    end

    private

        def generate_session_token
            session_token = SecureRandom::urlsafe_base64
            while User.exists?(session_token: session_token)
                session_token = SecureRandom::urlsafe_base64
            end
            return session_token
        end
end