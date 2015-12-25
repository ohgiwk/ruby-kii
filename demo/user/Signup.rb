require "KiiSDK"
require_relative "../Constants.rb"


kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

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