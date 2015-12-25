
class CloudException < Exception

    attr_reader :status
    attr_reader :resp

    def initialize(status, resp)
        @status = status
        @resp = resp
    end
end








