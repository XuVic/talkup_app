require_relative '../spec_helper.rb'

describe 'Test Issue Unit' do 

    describe 'Get All Issues Info' do 

        it 'HAPPY: It should be able to get issues information' do 
            result = TalkUp::IssueService.get_all(2)
            issues = TalkUp::IssuesRepresenter.new(OpenStruct.new).from_json result.value
            issues_view = TalkUp::View::Issues.new(issues)
            
            _(result.success?).must_equal true  
            _(issues_view.each_issues[0]).must_be_instance_of TalkUp::View::Issue
            _(issues_view.each_issues[0].title).wont_be_nil
        end
    end

    describe 'Issue Creation' do 

        it 'HAPPY: It should be able to create a issue' do 
            issue_data = { 'username' => 'Vic', 'issue_data' => DATA[:issues][0] }
            result = TalkUp::IssueService.create(issue_data)
            issue = TalkUp::IssueRepresenter.new(OpenStruct.new).from_json result.value
            issue_view = TalkUp::View::Issue.new(issue)

            _(result.success?).must_equal true
            _(issue_view.title).wont_be_nil
        end
    end

end