
class JsonRequestBody

    def self.parse_sym(json_str)
        parsed = JSON.parse json_str
        recur_sym(parsed)
    end

    def self.recur_sym(hash)
        if hash.class == Array
            hash.each_with_index do |v, i|
                hash[i] = recur_sym(v)
            end
        elsif hash.class == Hash
            hash.each do |k, v|
                hash[k] = recur_sym(v) if v.class == Hash || v.class == Array
            end
            Hash[hash.map { |k, v| [k.to_sym, v] }]
        end
    end
    
end