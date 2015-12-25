require "KiiSDK"
require_relative "../Constants.rb"

require "pp"

# ログイン
kiiAppAPI = KiiSDK.init(APP_ID, APP_KEY, SITE)

begin
    # バケット用のAPIオブジェクトを取得
    bucketAPI = kiiAppAPI.bucketAPI

    bucket = bucketAPI.getBucket('test')

    # クエリの条件を指定
    clause = KiiClause.equals('delete_flag', 0)


    condition = KiiCondition.new(clause)
    condition.setLimit(30)

    pp bucketAPI.query(bucket, condition)

rescue ex
    pp ex
end
