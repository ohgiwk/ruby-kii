require "KiiSDK"
require_relative "../Constants.rb"

require "pp"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)
objectAPI = kiiAppAPI.objectAPI

begin
    bucketAPI = kiiAppAPI.bucketAPI

    bucket = bucketAPI.getBucket('test')

    pp objectAPI.update(obj)

    pp objectAPI.updatePatch(obj)

rescue ex
    pp ex
end
