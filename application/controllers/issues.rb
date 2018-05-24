module TalkUp

    class App < Roda
       
        route('issues') do |routing|

            routing.get String do |section| 
                result = IssueService.get_all(section)
                    
                issues = build_view(result.value, IssuesRepresenter, View::Issues)

                view :'issue/issue', locals: {issues: issues, current_account: @current_account}
            end

        end
    end
end