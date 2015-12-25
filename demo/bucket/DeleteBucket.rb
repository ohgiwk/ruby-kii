require_relative "../Constants.rb"
require_relative "../../kii/KiiAppAPI.rb"
require "pp"

# initialize KiiAPI
kiiAppAPI = KiiAppAPI.new(APP_ID, APP_KEY, SITE)

begin
    kiiAppAPI.login(USER, PASSWORD)

    bucketAPI = kiiAppAPI.bucketAPI

    bucket = bucketAPI.getBucket('test')

    pp bucketAPI.delete(bucket)

rescue ex
    pp ex
end
