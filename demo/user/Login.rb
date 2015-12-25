require "KiiSDK"
require_relative "../Constants.rb"


kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    user = kiiAppAPI.login(USER, PASSWORD)
    p 'user id : ' + user.getPath
rescue CloudException => e
    p 'failed to login ' + e.status
    p e.resp
end


begin
    user = kiiAppAPI.loginAsAdmin(CLIENT_ID, CLIENT_SECRET)
    p 'user id : ' + user.getPath
rescue CloudException => e
    p 'failed to login ' + e.status
    p e.resp
end
