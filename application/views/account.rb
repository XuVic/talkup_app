module TalkUp
    module Views

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

            def action
                if @account == nil
                    'Login'
                else
                    'Logout'
                end
            end
        end
    end
end