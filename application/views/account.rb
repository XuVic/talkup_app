module TalkUp
    module View

        class Account
            
            def initialize(account_info=nil)
                @account = account_info
            end

            def token
                @account.token
            end

            def username
                return nil if @account == nil
                @account.username
            end

            def email
                return nil if @account == nil
                @account.email
            end

            def email_verificated?
                !username.nil?
            end

            def login?
                return (@account == nil) ? false : true
            end

            def action
                if login?
                    'Logout'
                else
                    'Login'
                end
            end
        end
    end
end