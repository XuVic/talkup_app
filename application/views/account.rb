module TalkUp
    module View

        class Account
            
            def initialize(account_info)
                @account = account_info
            end

            def username
                return nil if @account == nil
                @account.username
            end

            def email
                return nil if @account == nil
                @account.email
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