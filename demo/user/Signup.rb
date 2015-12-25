require_relative "../Constants.rb"
require_relative "../../kii/KiiAppAPI.rb"


kiiAppAPI = KiiAppAPI.new(APP_ID, APP_KEY, SITE)

begin
    userID = kiiAppAPI.signUp({
        "loginName" => "user_123456",
        "displayName" => "person test000",
        "country" => "JP",
        "password" => "123ABC"
        })

    p 'user id : ' + userID
rescue CloudException => e
    p 'failed to login ' + e.status
    p e.resp
end
