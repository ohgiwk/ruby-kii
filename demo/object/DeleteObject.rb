require "KiiSDK"
require_relative "../Constants.rb"
require "pp"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)
objectAPI = kiiAppAPI.objectAPI
bucketAPI = kiiAppAPI.bucketAPI

begin
    kiiAppAPI.login(USER, PASSWORD)

    data = {:name => "hoge"}

    postbucket = bucketAPI.getBucket("post")
    obj = objectAPI.create(postbucket, data)

    pp objectAPI.getObjectById(postbucket, obj.id)

    pp objectAPI.delete(obj)


rescue => ex
    pp ex
end
