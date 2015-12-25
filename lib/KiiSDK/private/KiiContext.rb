require_relative "./http/KiiHttpClientFactory.rb"

class KiiContext

    SITE_US = "https://api.kii.com/api"
    SITE_JP = "https://api-jp.kii.com/api"
	SITE_CN = "https://api-cn2.kii.com/api"

    attr_reader :appId
    attr_reader :appKey
    attr_reader :serverUrl
    attr_accessor :accessToken

    def initialize(appId, appKey, serverUrl)
        @appId = appId
        @appKey = appKey
        @serverUrl = serverUrl
        @clientFactory = KiiHttpClientFactory.new()
    end


    def setClientFactory(factory)
        @clientFactory = factory
    end


    def getNewClient()
        @clientFactory.newClient()
    end

end
