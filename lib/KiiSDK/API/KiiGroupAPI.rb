require_relative "../private/KiiGroup.rb"
require_relative "../private/CloudException.rb"

class KiiGroupAPI

    def initialize(context)
        @context = context
    end

    def group(group)
        KiiGroup.new(group)
    end


    def getJoinedGroups(user)
        getGroups(user, "is_member")
    end


    def getGroups(user, q)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/groups?#{q}=#{user.id}"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_GET)
        client.setKiiHeader(c, true)

        resp = client.send
        unless resp.status == "200"
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        result = []
        respJson = resp.getAsJson
        respGroups = respJson['groups']
        for respGroup in respGroups do
            result.push(toKiiGroup(respGroup))
        end

        return result
    end

    def toKiiGroup(respGroup)
        id = respGroup['groupID']
        name = respGroup['name']
        owner = respGroup['owner']

        return KiiGroup.new(id, name, owner)
    end


    def create(group)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/groups"

        client = c.getNewClient
        client.setUrl(url)
        client.setMethod(KiiHttpClient::HTTP_POST)
        client.setContentType("application/vnd.kii.GroupCreationRequest+json")
        client.setKiiHeader(c, true)

        resp = client.sendJson(group)
        unless resp.status == "201"
            raise CloudException.new(resp.status, resp.getAsJson)
        end

        respJson = resp.getAsJson
        id = respJson['groupID']
        name = group['name']
        owner = group['owner']

        return KiiGroup.new(id, name, owner)
    end


    def delete(group)
        c = @context
        url = "#{c.serverUrl}/apps/#{c.appId}/groups/#{group.id}"

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

    def changeGroupName()

    end

end
