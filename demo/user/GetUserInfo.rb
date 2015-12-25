require "KiiSDK"
require_relative "../Constants.rb"
require "pp"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)
userAPI = kiiAppAPI.userAPI

begin
    user = kiiAppAPI.login(USER, PASSWORD)

    pp userAPI.getUser(user)


rescue CloudException => e
    p e
end
