module TalkUp

    class App < Roda

        route('edit', 'comment') do |routing|
            
            routing.post do
                result = CommentService.edit( routing.params, @current_account.token)
                result.value
                
            end


        end
    end
end