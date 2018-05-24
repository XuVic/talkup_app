# Run pry -r <path/to/this/file>


require_relative '../init.rb'

def app
  TalkUp::App
end

data = {}
data[:accounts] = YAML.safe_load File.read('specs/seeds/account_seeds.yml')
data[:issues] = YAML.safe_load File.read('specs/seeds/issue_seeds.yml')
DATA = JsonRequestBody.parse_sym(data.to_json)