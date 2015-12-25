require_relative "../Constants.rb"
require_relative "../../kii/KiiAppAPI.rb"
require "pp"

kiiAppAPI = KiiAppAPI.new(APP_ID, APP_KEY, SITE)
objectAPI = kiiAppAPI.objectAPI
bucketAPI = kiiAppAPI.bucketAPI

begin
    kiiAppAPI.login(USER, PASSWORD)

    data = {:name => "hoge"}

    postbucket = bucketAPI.getBucket("post")
    obj = objectAPI.create(postbucket, data)
    pp obj


rescue => ex
    p ex
end
