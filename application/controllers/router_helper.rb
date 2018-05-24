
module TalkUp

    class App < Roda

        def response_handler(result, outcome)
            if result.success?
                flash[:notice] = "OK"
                return outcome[0]
            else
                info = JsonRequestBody.parse_sym result.value
                error = View::Error.new(info)
                flash[:error] = error
                return outcome[1]
            end
        end

        def build_view(result, represneter, view)   
            view.new( represneter.new(OpenStruct.new).from_json result ) if result != nil
            view.new(result)
        end
        
    end
end