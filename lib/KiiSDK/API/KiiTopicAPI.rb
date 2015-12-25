require_relative '../private/KiiContext.rb'
require_relative '../private/CloudException.rb'

class KiiTopicAPI

    def initialize(context)
        @context = context
    end

    def create(topic)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{topic.getPath}"
        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_PUT)
        client.setKiiHeader(c, true)

        resp = client.send
        unless resp.status == '204'
            raise CloudException.new(resp.status, resp.getAsJson)
        end
    end

    def sendMessage(topic, message)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}#{topic.getPath}/push/messages"
        body = message.toJson

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setKiiHeader(c, true)
        client.setContentType('application/vnd.kii.SendPushMessageRequest+json')

        resp = client.sendJson(body)
        unless resp.status == '201'
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson
        return respJson['pushMessageID']
    end
end
