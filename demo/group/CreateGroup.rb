require_relative "../Constants.rb"
require_relative "../../kii/KiiAppAPI.rb"

require "pp"

kiiAppAPI = KiiAppAPI.new(APP_ID, APP_KEY, SITE)

begin
    user = kiiAppAPI.login(USER, PASSWORD)

    groupAPI = kiiAppAPI.groupAPI

    group = {
        "name" => "test",
        "owner" => user.id,
        "members" => [
          "{USER_ID_OF_MEMBER_1}",
          "{USER_ID_OF_MEMBER_2}"
        ]
    }

    pp groupAPI.create(group)

rescue => ex
    pp ex
end
