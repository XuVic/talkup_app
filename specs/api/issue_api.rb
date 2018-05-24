require_relative '../spec_helper.rb'

describe 'Test Api Gateway' do  
    before do
        @gateway = TalkUp::ApiGateway.new
    end

    describe 'Test issue' do 

        describe 'Issue Creation' do 

            it 'HAPPY: should be able to create issue' do 
                issue_data = {:username => 'Vic', :issue_data => DATA[:issues][1]}
                response = @gateway.issue_create(issue_data)

                _(response.code).must_equal 201
            end

        end

        describe 'Issues Details' do 

            it 'HAPPY: should be able to get all issues' do 
                response = @gateway.issues_info(2)

                _(response.code).must_equal 200 
            end
        end
    end
end