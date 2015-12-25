require_relative "../private/CloudException"

class KiiUserAPI

    OS_ANDROID = 1
    OS_IOS = 2

    def initialize(context)
        @context = context
    end


    def getUser(user)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{user.getPath}"

        execGet(url)
    end

    def delete
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/users/me"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_DELETE)
        client.setKiiHeader(c, true)

        resp = client.send

        unless resp.status == '204'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        return resp
    end


    def findByUsername(username)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/user/LOGIN_NAME:#{username}"

        execGet(url)
    end


    def findByEmail(email)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/user/EMAIL:#{email}"

        execGet(url)
    end


    def findByPhone(phone)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/user/PHONE:#{phone}"

        execGet(url)
    end


    def execGet(url)
        c = @context

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_GET)
        client.setKiiHeader(c, true)

        resp = client.send
        unless resp.status == '200'
            raise CloudException.new(resp.status, resp.getAsJson)
        end
        respJson = resp.getAsJson
        userId = respJson['userID']

        info = KiiUser.new(userId)
        info.data = respJson

        return info
    end


    def installDevice
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/installations"

        if os == OS_IOS
            data['development'] = development
        end

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setKiiHeader(c, true)
        client.setContentType('application/vnd.kii.InstallationCreationRequest+json')

        resp = client.sendJson(data)
        unless resp.status == '201'
            raise CloudException.new(resp.status, resp.getAsJson)
        end
        respJson = resp.getAsJson
        return respJson['installationID']
    end


    def uninstallDevice(os, token)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/installations/#{toDeviceType(os)}:#{token}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_DELETE)
        client.setKiiHeader(c, true)

        resp = client.send
        unless resp.status == '204'
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end

    def toDeviceType(os)
        case $os
        when UserAPI::OS_ANDROID
            return 'ANDROID'
        when UserAPI::OS_IOS
            return 'IOS'
        else
            return ''
        end
    end

    def subscribe(user, target)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{target.getPath}/push/subscriptions#{user.getPath}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_PUT)
        client.setKiiHeader(c, true)

        resp = client.send
        unless resp.status == '204'
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end
end
