module TalkUp

    class App < Roda

        route('github_sso_callback', 'auth') do |routing|

            routing.get do 
                github_account = AuthGithubAccount.new.call({config: App.config, code: routing.params['code']})
                SecureSession.new(session).set(:current_account, github_account.value) if github_account.success?
                location = github_account.success? ? '/' : '/auth/login'
                if github_account.failure?
                    error = JSON.parse(github_account)['account']
                    flash[:error] = error
                end
                routing.redirect location
            end
        end
    end
end