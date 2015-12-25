require "KiiSDK"
require_relative "../Constants.rb"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    # prepare user data
    data = {
        "loginName" => "hoge", #required
        "password" => "fuga", # required
        "displayName" => "hoge",
        "country" => "JP",
    }

    # create a user and login
    user = kiiAppAPI.signUp(data)

    p 'user id : ' + user.id

rescue CloudException => e
    p 'failed to login ' + e.status
    p e.resp
end
