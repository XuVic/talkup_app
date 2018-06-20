module TalkUp

    class App < Roda

        route('create', 'issue') do |routing|
            
            routing.get String  do |section| 
                result = TalkUp::AccountService.collaborators(@current_account.token)
                collaborators_info = TalkUp::CollaboratorsRepresenter.new(OpenStruct.new).from_json result.value
                collaborators = TalkUp::View::Collaborators.new(collaborators_info)

                view :'issue/create', locals: {issue: false, collaborators: collaborators, section: section}
            end

            routing.post do
                routing.params['anonymous'] = routing.params['anonymous'].to_i
                collaborators = routing.params['collaborators']
                routing.params.delete('collaborators')
                input = {:issue_data => routing.params, token: @current_account.token, collaborators: collaborators}
                result = TalkUp::CreateIssue.new.call( input )            
                if result.failure
                    flash[:error] = result.value
                    routing.redirect "/issue/create/#{routing.params['section']}"
                end
                issue_info = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
                issue = TalkUp::View::Issue.new(issue_info)
                location = issue.link(:show)

                routing.redirect location
            end


        end
    end
end