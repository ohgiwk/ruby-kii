require "json"

class KiiHttpResponse

    attr_reader :status

    def initialize(status, headers, body)
        @status = status
        @headers = headers
        @body = body
    end

    def getAllHeaders()
        @headers
    end

    def getAsJson()
        JSON.parse(@body)
    end
end
