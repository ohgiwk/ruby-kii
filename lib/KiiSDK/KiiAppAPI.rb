require_relative "./API/KiiUserAPI.rb"
require_relative "./API/KiiBucketAPI.rb"
require_relative "./API/KiiObjectAPI"
require_relative "./API/KiiGroupAPI.rb"
require_relative "./API/KiiTopicAPI"

require_relative "./private/KiiContext.rb"
require_relative "./private/KiiCondition.rb"
require_relative "./private/KiiClause.rb"
require_relative "./private/KiiUser.rb"
require_relative "./private/KiiGroup.rb"
require_relative "./private/Kiibucket.rb"
require_relative "./private/KiiObject.rb"

require_relative "./private/CloudException"
require_relative "./private/http/KiiHttpClient.rb"


class KiiAppAPI

    attr_reader :context
    attr_reader :userAPI
    attr_reader :bucketAPI
    attr_reader :objectAPI
    attr_reader :groupAPI
    attr_reader :topicAPI

    def initialize(appId, appKey, serverUrl)

        @context = KiiContext.new(appId, appKey, serverUrl)

        @userAPI = KiiUserAPI.new(@context)
        @bucketAPI = KiiBucketAPI.new(@context)
        @objectAPI = KiiObjectAPI.new(@context)
        @groupAPI = KiiGroupAPI.new(@context)
        @topicAPI = KiiTopicAPI.new(@context)
    end



    def signUp(userData)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/users"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setContentType 'application/vnd.kii.RegistrationRequest+json'
        client.setKiiHeader(c, false)

        resp = client.sendJson(userData)

        unless resp.status == '201'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson

        return respJson['userID']
    end


    def login(userIdentifier, password)
        body = {
            :username => userIdentifier,
            :password => password
        }
        execLogin(body)
    end


    def loginAsAdmin(client_id, clientSecret)
        body = {
            :client_id => client_id,
            :client_secret => clientSecret
        }
        execLogin(body)
    end


    def execLogin(body)
        c = @context
        url = "#{c.serverUrl}/oauth2/token"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setKiiHeader(c, false)
        client.setContentType('application/json')

        resp = client.sendJson(body)
        unless resp.status == '200'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson

        userId = respJson['id']
        token = respJson['access_token']
        c.accessToken = token

        return KiiUser.new(userId)
    end
end
