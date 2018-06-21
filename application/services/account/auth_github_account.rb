require 'dry-monads'
require 'dry/transaction'
require 'http'

module TalkUp

    class  AuthGithubAccount
        include Dry::Transaction


        step :get_access_token
        step :get_github_account

        def get_access_token(input)
            
            token_response = HTTP.headers(accept: 'application/json')
                                .post(input[:config].GH_TOKEN_URL,
                                      json: { client_id: input[:config].GH_CLIENT_ID,
                                              client_secret: input[:config].GH_CLIENT_SECRET,
                                              code: input[:code]  })
            raise unless token_response.status < 400
            input[:access_token] = token_response.parse['access_token']
            Right(input)
        end

        def get_github_account(input)
            signed_token = SecureMessage.sign(input[:access_token])
            puts signed_token
            response = ApiGateway.new.sso_auth(signed_token)
            if response.code < 300
                Right(response.message)
            else
                Left("Empty")
            end
        end
    end
    
end