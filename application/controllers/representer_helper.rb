
module TalkUp

    class App < Roda
        
        def build_representer(result, represneter)
            return nil if result == nil
            
            represneter.new(OpenStruct.new).from_json result
        end
    end
end