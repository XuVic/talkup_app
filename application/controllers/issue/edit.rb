module TalkUp

    class App < Roda

        route('edit', 'issue') do |routing|
            
            routing.get String  do |issue_id|
                result = IssueService.get_by_id({:issue_id => issue_id, :token => @current_account.token})
                issue = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
                issue = TalkUp::View::Issue.new(issue)
                
                view :'issue/create', locals: {issue: issue, section: issue.section}
            end

            routing.post do
                routing.params['anonymous'] = '0' if routing.params['anonymous'].nil?
                routing.params['anonymous'] = routing.params['anonymous'].to_i
                issue_id = routing.params['id']
                routing.params.delete('id')
                result = TalkUp::IssueEdit.new.call({issue_id: issue_id, issue_data: routing.params, token: @current_account.token})
                if result.failure
                     flash[:error] = result.value
                     routing.redirect "/issue/edit/#{issue_id}"
                end
                issue_info = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
                issue = TalkUp::View::Issue.new(issue_info)
                location = issue.link(:show)

                routing.redirect location
            end

        end
    end
end