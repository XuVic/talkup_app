module TalkUp

    class App < Roda
       
        route('comment') do |routing|

            routing.on 'delete' do
                routing.route('delete', 'comment')
            end

            routing.on 'edit' do
                routing.route('edit', 'comment')
            end

            routing.post do
                result = CommentService.create( routing.params, @current_account.token)
                issue = TalkUp::CommentRepresenter.new(OpenStruct.new).from_json result.value
                
                result.value
            end
        end
    end
end