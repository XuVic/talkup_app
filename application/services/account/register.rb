require 'dry-monads'
require 'dry/transaction'
require_relative '../../../lib/json_request.rb'

module TalkUp

    class Register
        include Dry::Transaction
        
        step :register_form_verification
        step :email_verification
        step :password_form_verification
        step :pass_info

        def register_form_verification(input)
            credentials = Form::Registration.call(input)
            if credentials.success?
                Right(input)
            else
                error = credentials.errors.map do |k,v|
                    "#{k} #{v.join(',')}"
                end.join(', ')
                Left(error)
            end
        end

        def email_verification(input)
            config = input[:config]
            input = JsonRequestBody.parse_sym(input.to_json)
            input.delete(:config)
            if input[:password].nil?
                registeration_token = SecureMessage.encrypt(input.to_json)
                input[:verification_url] = "#{config.APP_URL}/account/register/#{registeration_token}"
                signed_registration = SecureMessage.sign(input)
                result = ApiGateway.new.account_create(signed_registration)
                Left("Please verify email with #{input[:email]}" )
            else
                input.delete(:verification_url)
                Right(input)
            end
        end

        def password_form_verification(input)
            credentials = Form::Passwords.call(input)
            if credentials.success?
                Right(input)
            else
                error = credentials.errors.map do |k,v|
                    "#{k} #{v.join(',')}"
                end.join(', ')
                Left(error)
            end
        end
        def pass_info(input)
            signed_registration = SecureMessage.sign(input)
            result = ApiGateway.new.account_create(signed_registration)
            if result.code < 300
                Right('Account Created')
            else
                Left(result.message)
            end
        end

    end
end