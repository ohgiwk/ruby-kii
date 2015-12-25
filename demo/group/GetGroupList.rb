require_relative "../Constants.rb"
require_relative "../../kii/KiiAppAPI.rb"

require "pp"

kiiAppAPI = KiiAppAPI.new(APP_ID, APP_KEY, SITE)

begin
    user = kiiAppAPI.login(USER, PASSWORD)

    groupAPI = kiiAppAPI.groupAPI

    pp groupAPI.getJoinedGroups(user)

rescue => ex
    pp ex
end
