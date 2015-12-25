require_relative "./KiiHttpClient.rb"

class KiiHttpClientFactory
    def newClient
        KiiHttpClient.new()
    end
end
