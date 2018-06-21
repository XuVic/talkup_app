require_relative '../spec_helper.rb'

describe 'Test Api Gateway' do  
    before do
        @gateway = TalkUp::ApiGateway.new
    end

    describe 'Test issue' do 

        describe 'Issue Creation' do 

            it 'HAPPY: should be able to create issue' do 
                
                issue_data = {:issue_data => DATA[:issues][1]}
                response = @gateway.issue_create(issue_data, DATA[:accounts][0][:token])

                _(response.code).must_equal 201
            end

        end
        
        describe 'Issues Update' do 

            it 'HAPPY: should be able to update a issue' do
                issues = JSON.parse(@gateway.issues_info(1, DATA[:accounts][0][:token]).message)
                issue_id = issues['issues'][0]['id']

                response = @gateway.issue_update(issue_id, DATA[:issues][1], DATA[:accounts][0][:token])

                _(response.code).must_equal 200 
            end
        end

        describe 'Issues Details' do 

            it 'HAPPY: should be able to get all issues' do
                response = @gateway.issues_info(1, DATA[:accounts][0][:token])

                _(response.code).must_equal 200 
            end
            it 'HAPPY: should be able to get all issues with account' do
                response = @gateway.issues_info(nil, DATA[:accounts][0][:token])

                _(response.code).must_equal 200 
            end
        end

        describe 'Issue Detail' do
            it 'HAPPY: should be able to get detail of issue' do
                issues = JSON.parse(@gateway.issues_info(1, DATA[:accounts][0][:token]).message)
                issue_id = issues['issues'][0]['id']

                response = @gateway.issue_info(issue_id, DATA[:accounts][0][:token])

                _(response.code).must_equal 200
            end
        end

        describe 'Issue Delete' do 
            it 'HAPPY: should be able to delete issue' do 
                issues = JSON.parse(@gateway.issues_info(1, DATA[:accounts][0][:token]).message)
                issue_id = issues['issues'][0]['id']
                response = @gateway.issue_delete(issue_id, DATA[:accounts][0][:token])

                _(response.code).must_equal 200
            end
        end

        describe 'Issue Collaborators' do
            it 'HAPPY: should be able to add collaborators' do 
                issues = JSON.parse(@gateway.issues_info(1, DATA[:accounts][0][:token]).message)
                issue_id = issues['issues'][0]['id']
                collaborators = {collaborators: ['Vic', 'Shelly']}
                response = @gateway.add_collaborators(issue_id, collaborators, DATA[:accounts][0][:token])

                _(response.code).must_equal 201
            end

            it 'HAPPY: should be able to remove collaborator' do 
                issues = JSON.parse(@gateway.issues_info(1, DATA[:accounts][0][:token]).message)
                issue_id = issues['issues'][0]['id']
                response = @gateway.remove_collaborator(issue_id, {collaborator: "Vic"}, DATA[:accounts][0][:token])

                _(response.code).must_equal 200
            end
            
        end
    end
end