require_relative '../spec_helper.rb'


describe 'Test Api Gateway' do 
    before do
        @gateway = TalkUp::ApiGateway.new
        issues = JSON.parse(@gateway.issues_info(1, DATA[:accounts][0][:token]).message)
        @issue_id = issues['issues'][0]['id']
    end

    describe 'Test Comment Route' do 

        it 'HAPPY: it should be able to create a comment.' do 
            data = {comment_data: {content: 'test', anonymous: 1}, issue_id: @issue_id}
            response = @gateway.comment_create(data, DATA[:accounts][0][:token])

            _(response.code).must_equal 201
        end

        it 'HAPPY: it should be able to delete a comment' do 
            data = {comment_data: {content: 'test', anonymous: 1}, issue_id: @issue_id}
            response = @gateway.comment_create(data, DATA[:accounts][0][:token])
            result = JSON.parse response.message
            data = {comment_id: result['id']}
            response = @gateway.comment_delete(data, DATA[:accounts][0][:token])
            
            _(response.code).must_equal 200
        end

        it 'HAPPY: it should be able to edit a comment' do 
            data = {comment_data: {content: 'test', anonymous: 1}, issue_id: @issue_id}
            response = @gateway.comment_create(data, DATA[:accounts][0][:token])
            result = JSON.parse response.message
            data = {comment_data: {content:'edited'}, comment_id: result['id']}
            response = @gateway.comment_edit(data, DATA[:accounts][0][:token])

            _(response.code).must_equal 200
        end
    end
end