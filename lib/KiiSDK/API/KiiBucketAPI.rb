require_relative "../private/Kiibucket.rb"
require_relative "../private/CloudException.rb"

class KiiBucketAPI

    def initialize(context)
        @context = context
    end


    def getBucket(bucket, scope: KiiBucket::SCOPE_APPLICATION, id: "")
        KiiBucket.new(bucket, scope, id)
    end


    # バケットからデータを取得する
    def query(bucket, condition)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{bucket.getPath}/query"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setKiiHeader(c, false)
        client.setContentType('application/vnd.kii.QueryRequest+json')

        resp = client.sendJson(condition.toJson)

        unless resp.status == '200'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson

        if respJson.has_key?('nextPaginationKey')
            condition.setPaginationKey(respJson['nextPaginationKey'])
        else
            condition.setPaginationKey(nil)
        end

        respArray = respJson['results']
        result = []
        for item in respArray do
            id = item['_id']
            version = item['_version']

            object = KiiObject.new(bucket, id, item)
            object.version = version
            result.push(object)
        end

        return result
    end


    # object data needed when create new bucket
    def create(bucket, object)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{bucket.path}/objects"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setContentType "application/vnd.#{c.appId}.mydata+json"
        client.setKiiHeader(c, true)

        resp = client.sendJson(object)

        unless resp.status == '201'
           raise CloudException.new(resp.status, resp.getAsJson)
        end

        return resp
    end



    # バケットを削除する
    def delete(bucket)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{bucket.path}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_DELETE)
        client.setKiiHeader(c, true)

        # リクエストを送信
        resp = client.send

        unless resp.status == '204'
           raise CloudException.new(resp.status, resp.getAsJson)
        end

        return resp
    end
end
