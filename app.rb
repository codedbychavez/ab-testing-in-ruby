require 'sinatra'
require 'configcat'
require 'dotenv'

# Load environment variables from .env file
Dotenv.load

# ConfigCat client initialization
configcat_client = ConfigCat.get(
  ENV['CONFIGCAT_SDK_KEY']
)

user_object = ConfigCat::User.new(
  '7b8c03a6-502d-4d6b-8d67-fc5e1a2b9a94',
  email: 'john@example',
  country: 'France',
)

get '/' do
  @is_my_feature_flag_enabled = configcat_client.get_value('myfeatureflag', false, user_object)
  erb :index
end
