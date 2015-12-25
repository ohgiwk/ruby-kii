require "KiiSDK"
require_relative "../Constants.rb"
require "pp"

kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

def createApplicationScopeBucket(kiiAppAPI)

    kiiAppAPI.login(USER, PASSWORD)
    bucketAPI = kiiAppAPI.bucketAPI
    testBucket = bucketAPI.getBucket('test')

    object = {
        "name" => "test",
        "score" => 1000,
    }

    pp bucketAPI.create(testBucket, object)

    rescue ex
        pp ex
end

createApplicationScopeBucket(kiiAppAPI)


def createGroupScopeBucket(kiiAppAPI)


end
