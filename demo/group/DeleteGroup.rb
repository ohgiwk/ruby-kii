require "KiiSDK"
require_relative "../Constants.rb"

require "pp"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    kiiAppAPI.login(USER, PASSWORD)

    groupAPI = kiiAppAPI.groupAPI

    testGroup = groupAPI.group("test")

    pp groupAPI.delete(testGroup)

rescue => ex
    pp ex
end
