module TalkUp

    class App < Roda

        route('delete', 'comment') do |routing|
            
            routing.post do
                result = CommentService.delete( routing.params, @current_account.token)
                            
                result.value
            end


        end
    end
end