module TalkUp
  class App < Roda
    route('account') do |routing|
      routing.on 'register' do
          routing.route('register', 'account')
      end
      
      routing.on do
        # GET /account/[username]
        routing.get String do |username|
          if @current_account.login?
            input = {section: nil, token: @current_account.token}
            result = IssueService.get_all(input)
            issues = TalkUp::IssuesRepresenter.new(OpenStruct.new).from_json result.value
            issues = TalkUp::View::Issues.new(issues, nil)
            view :'account/account', locals: { current_account: @current_account, issues: issues }
          else
            routing.redirect '/auth/login'
          end
        end
      end
    end
  end
end
