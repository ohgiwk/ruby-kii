require_relative "../Constants.rb"
require_relative "../../kii/KiiAppAPI.rb"

require "pp"

kiiAppAPI = KiiAppAPI.new(APP_ID, APP_KEY, SITE)

begin
    kiiAppAPI.login(USER, PASSWORD)

    groupAPI = kiiAppAPI.groupAPI

    testGroup = groupAPI.group("test")

    pp groupAPI.delete(testGroup)

rescue => ex
    pp ex
end
