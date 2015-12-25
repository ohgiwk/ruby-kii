require_relative "../private/KiiObject.rb"
require_relative "../private/CloudException.rb"

class KiiObjectAPI

    def initialize(context)
        @context = context
    end

    def getObjectById(bucket, object_id)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{bucket.getPath}/objects/#{object_id}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod KiiHttpClient::HTTP_GET
        client.setKiiHeader(c, true)

        resp = client.send

        unless resp.status == '200'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson
        respHeaders = resp.getAllHeaders
        version = respHeaders['etag']
        id = respJson['_id']
        data = respJson

        kiiobj = KiiObject.new(bucket, id, data)
        kiiobj.version = version

        return kiiobj
    end


    def create(bucket, data)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{bucket.getPath}/objects"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod KiiHttpClient::HTTP_POST
        client.setKiiHeader(c, true)
        client.setContentType('application/json')

        resp = client.sendJson(data)

        unless resp.status == '201'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson
        respHeaders = resp.getAllHeaders
        version = respHeaders['etag']
        id = respJson['objectID']

        kiiobj = KiiObject.new(bucket, id, data)
        kiiobj.version = version

        return kiiobj
    end


    def update(object)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath}"

        client = c.getNewClient
        client.setUrl url
        client.setMethod KiiHttpClient::HTTP_PUT
        client.setContentType('application/json')

        resp = client.sendJson(object.data)

        if resp.status == '200' || resp.status == '201'
            respHeaders = resp.getAllHeaders
            version = respHeaders['etag']
            object.version = version
            return object

        else
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end


    def upatePatch(object, patch)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setKiiHeader(c, true)
        client.setContentType('application/json')
        client.setHeader('X-HTTP-Method-Override', 'PATCH')

        resp = client.sendJson(patch)

        if resp.status == '200'
            respHeaders = resp.getAllHeaders
            version = respHeaders['etag']
            object.version = version

            #update
            patch.each do | k, v |
                object.data[k] = v
            end

        elsif resp.status = '201'
            respHeaders = resp.getAllHeaders
            version = respHeaders['etag']
            object.version = version
            return object
        else
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end


    def updateIfUnmodified
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath}"

        client = c.getNewClient
        client.setUrl url
        client.setMethod KiiHttpClient::HTTP_PUT
        client.setKiiHeader(c, true)
        client.setHeader('If-Match', object.version)
        client.setContentType('application/json')

        resp = client.sendJson(object.data)

        if resp.status == '200' || resp.status == '201'
            respHeaders = resp.getAllHeaders
            version = respHeaders['etag']
            object.version = version
            return object
        else
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end


    def delete(object)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath()}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_DELETE)
        client.setKiiHeader(c, true)

        resp = client.send
        unless resp.status == "204"
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        return resp
    end


    def updateBody(object, contentType, data)
        c = this.context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath}/body"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_PUT)
        client.setKiiHeader(c, true)
        client.setContentType(contentType)

        resp = client.sendFile(data)
        if resp.status == '200' || resp.status == '201'
            return object
        else
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end

    def downloadBody(object, fp)
        c = this.context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath}/body"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_GET)
        client.setKiiHeader(c, true)

        resp = client.sendForDownload(fp)

        if resp.status == '200' || resp.status == '201'
            return true
        else
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end

    def publish(object)
        c = this.context
        url = "#{c.serverUrl}/apps/#{c.appId}#{object.getPath}/body/publish"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setKiiHeader(c, true)
        client.setContentType('application/vnd.kii.ObjectBodyPublicationRequest+json')

        resp = client.sendJson(nil)

        if resp.status == '201'
            respJson = resp.getAsJson
            return respJson['url']
        end

    rescue
        raise CloudException.new(resp.status, resp.getAsJson)
    end

end
