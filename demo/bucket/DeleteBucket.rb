require "KiiSDK"
require_relative "../Constants.rb"
require "pp"


kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    kiiAppAPI.login(USER, PASSWORD)

    bucketAPI = kiiAppAPI.bucketAPI

    bucket = bucketAPI.getBucket('test')

    pp bucketAPI.delete(bucket)

rescue ex
    pp ex
end
