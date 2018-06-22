module TalkUp

    class App < Roda
       
        route('issue') do |routing|

            routing.on 'create' do
                routing.route('create', 'issue')
            end
            routing.on 'edit' do
                routing.route('edit', 'issue')
            end
            routing.on 'delete' do 
                routing.route('delete', 'issue')
            end
            routing.on 'collaborators' do 
                routing.route('collaborators', 'issue')
            end

            routing.get String do |issue_id| 
                result = IssueService.get_by_id({:issue_id => issue_id, :token => @current_account.token})
                issue = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
                issue = TalkUp::View::Issue.new(issue)
                view :'issue/issue', locals: {issue: issue}
            end

            routing.post do
                result = IssueService.create({:issue_data => routing.params}, @current_account.token)
                issue = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
                issue = TalkUp::View::Issue.new(issue)
                location = "/issue/#{issue.id}"

                routing.redirect location
            end
        end
    end
end