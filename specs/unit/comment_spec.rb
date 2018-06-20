require_relative '../spec_helper.rb'

describe "Test Comment Unit" do 

    describe "Create comment" do 

        it 'HAPPY: it should be able to create one.' do 
            data = {comment_data: {content: 'test', anonymous: 1}, issue_id: DATA[:issues][0][:id]}
            result = TalkUp::CommentService.create(data, DATA[:accounts][0][:token])
            comment = TalkUp::CommentRepresenter.new(OpenStruct.new).from_json result.value
            comment_view = TalkUp::View::Comment.new(comment)

            _(comment_view.content).must_equal 'test'
            _(comment.to_json).must_be_kind_of String
            _(comment_view.can_edit?).must_equal true
        end

        it 'HAPPY: it should be able to delete one.' do 
            data = {comment_data: {content: 'test', anonymous: 1}, issue_id: DATA[:issues][0][:id]}
            result = TalkUp::CommentService.create(data, DATA[:accounts][0][:token])
            comment = TalkUp::CommentRepresenter.new(OpenStruct.new).from_json result.value
        
            data = {comment_id: comment.id}
            result = TalkUp::CommentService.delete(data, DATA[:accounts][0][:token])
            result = JSON.parse result.value

            _(result['message']).must_equal 'Deleted'
        end
    end

end