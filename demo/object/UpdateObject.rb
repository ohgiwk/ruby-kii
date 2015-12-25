require "KiiSDK"
require_relative "../Constants.rb"

require "pp"

# ログイン
kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    bucketAPI = kiiAppAPI.bucketAPI

    bucket = bucketAPI.getBucket('test')

    clause = KiiClause.equals('delete_flag', 0)
    condition = KiiCondition.new(clause)
    condition.setLimit(30)

    pp bucketAPI.query(bucket, condition)

rescue ex
    pp ex
end
