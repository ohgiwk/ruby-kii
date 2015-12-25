require "KiiSDK"
require_relative "../Constants.rb"

require "pp"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    user = kiiAppAPI.login(USER, PASSWORD)

    groupAPI = kiiAppAPI.groupAPI

    pp groupAPI.getJoinedGroups(user)

rescue => ex
    pp ex
end
