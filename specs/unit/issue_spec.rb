require_relative '../spec_helper.rb'

describe 'Test Issue Unit' do 

    describe 'Get All Issues Info' do 

        it 'HAPPY: It should be able to get issues information' do
            input = {section:1, token: DATA[:accounts][0][:token]} 
            result = TalkUp::IssueService.get_all(input)
            issues = TalkUp::IssuesRepresenter.new(OpenStruct.new).from_json result.value
            issues_view = TalkUp::View::Issues.new(issues, 2)
            
            _(result.success?).must_equal true  
            _(issues_view.each_issues[0]).must_be_instance_of TalkUp::View::Issue
            _(issues_view.each_issues[0].title).wont_be_nil
        end
    end

    describe 'Get one Issue by id' do 

        it 'HAPPY: It should be able to get details of one issue' do 
            account_json = TalkUp::AuthCredentials.new.call({:username => 'Vic', :password => 'mypassword'})
            account = JsonRequestBody.parse_sym account_json.value
            result = TalkUp::IssueService.get_by_id({:issue_id => DATA[:issues][0][:id],:token => account[:token]})
            issue = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
            issue_view = TalkUp::View::Issue.new(issue)

            _(result.success?).must_equal true
            _(issue_view.id).must_equal DATA[:issues][0][:id]
            _(issue_view.comments[0]).must_be_kind_of TalkUp::View::Comment

        end
    end

    describe 'Issue Edit' do 
        it 'HAPPY: It should be able to edit a issue' do 
            account_json = TalkUp::AuthCredentials.new.call({:username => 'Vic', :password => 'mypassword'})
            account = JsonRequestBody.parse_sym account_json.value
            issue_data = DATA[:issues][0]
            issue_data.delete(:id)
            issue_data[:title] = 'edited title'
            result = TalkUp::IssueEdit.new.call({issue_id: DATA[:issues][0][:id], issue_data: issue_data, token: account[:token]})
            
            _(result.success?).must_equal true
        end
    end

    describe 'Issue Creation' do 

        it 'HAPPY: It should be able to create a issue' do 
            account_json = TalkUp::AuthCredentials.new.call({:username => 'Vic', :password => 'mypassword'})
            account = JsonRequestBody.parse_sym account_json.value
            data = DATA[:issues][1]
            input = {issue_data: data, token: account[:token]}
            input[:collaborators] = ['Shelly']
            result = TalkUp::CreateIssue.new.call(input)            
            issue = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
            issue_view = TalkUp::View::Issue.new(issue)
            _(result.success?).must_equal true
            _(issue_view.id).wont_be_nil
        end
    end

end