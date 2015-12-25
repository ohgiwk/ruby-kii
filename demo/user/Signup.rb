require "KiiSDK"
require_relative "../Constants.rb"


kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    userID = kiiAppAPI.signUp({
        "loginName" => "hoge",
        "displayName" => "hoge",
        "country" => "JP",
        "password" => "fuga"
        })

    p 'user id : ' + userID
rescue CloudException => e
    p 'failed to login ' + e.status
    p e.resp
end
