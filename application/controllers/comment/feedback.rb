module TalkUp

    class App < Roda

        route('feedback', 'comment') do |routing|
            
            routing.post do
                result = CommentService.add_feedback( routing.params, @current_account.token)
                
                result.value
            end


        end
    end
end