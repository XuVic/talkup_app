module TalkUp

    class App < Roda

        route('delete', 'issue') do |routing|
            
            routing.get String  do |issue_id|
                input = {issue_id: issue_id, token: @current_account.token}
                result = IssueService.delete(input)
                puts result.value
                flash[:notice] = 'deleted'
                routing.redirect '/'
            end

        end
    end
end