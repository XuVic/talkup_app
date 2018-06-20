module TalkUp

    class App < Roda
       
        route('issues') do |routing|

            routing.get String do |section| 
                if !@current_account.login?
                    flash[:notice] = 'Please login.'
                    routing.redirect '/auth/login'
                end
                input = {section: section, token: @current_account.token}
                result = IssueService.get_all(input)
                issues = TalkUp::IssuesRepresenter.new(OpenStruct.new).from_json result.value
                issues = TalkUp::View::Issues.new(issues, section)
                
                view :'issue/issues', locals: {issues: issues}
            end
        end
    end
end