require 'rack/session/redis'
require 'rack/ssl-enforcer'
require 'secure_headers'

module TalkUp
    
    class App < Roda
        
        
        ONE_MONTH = 30*24*60*60


        configure :development, :test do
            require 'rack/test'
            include Rack::Test::Methods

        
            use Rack::Session::Cookie, expire_after: ONE_MONTH,
                secret: config.SESSION_SECRET
            def self.reload!
                exec 'pry -r ./specs/test_load_all'
            end
        end

        configure :production do 
            use Rack::SslEnforcer, :hsts => true

            use Rack::Session::Redis, expire_after: ONE_MONTH, redis_server: App.config.REDIS_URL
        end

        configure do 
            SecureSession.setup(config)
        end

        SecureHeaders::Configuration.default do |config|
            config.cookies = {
                secure: true,
                httponly: true,
                samesite: {
                strict: true
                }
            }

            config.x_frame_options = 'DENY'
            config.x_content_type_options = 'nosniff'
            config.x_xss_protection = '1'
            config.x_permitted_cross_domain_policies = 'none'
            config.referrer_policy = 'origin-when-cross-origin'

            config.csp = {
                report_only: false,
                preserve_schemes: true,
                default_src: %w['self'],
                child_src: %w['self'],
                connect_src: %w[wws:],
                img_src: %w['self'],
                font_src: %w['self' https://maxcdn.bootstrapcdn.com],
                script_src: %w['self' https://code.jquery.com https://maxcdn.bootstrapcdn.com],
                style_src: %w['self' 'unsafe-inline' https://maxcdn.bootstrapcdn.com https://cdnjs.cloudflare.com],
                form_action: %w['self'],
                frame_ancestors: %w['none'],
                object_src: %w['none'],
                block_all_mixed_content: true,
                report_uri: %w[/security/report_csp_violation]
            }

        end
    end
end