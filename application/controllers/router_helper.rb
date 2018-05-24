
module TalkUp

    class App < Roda
        
        def build_representer(result, represneter)
            return nil if result == nil
            
            represneter.new(OpenStruct.new).from_json result
        end

        def response_handler(result, location)
            if result.success?
                flash[:notice] = "OK"
                return location[0]
            else
                info = JsonRequestBody.parse_sym result.value
                error = Views::Error.new(info)
                flash[:error] = error
                return location[1]
            end
        end

    end
end