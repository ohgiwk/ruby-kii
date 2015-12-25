require_relative "./KiiHttpResponse.rb"
require_relative "./KiiHttpClientObserver.rb"

require "net/http"
require "uri"
require "json"

class KiiHttpClient

    HTTP_GET = 1
    HTTP_POST = 2
    HTTP_PUT = 3
    HTTP_DELETE = 4

    def setUrl(url)
        @uri = URI.parse(url)
        return self
    end

    def setMethod(method)
        case method
        when HTTP_GET then
            @req = Net::HTTP::Get.new(@uri.request_uri)

        when HTTP_POST then
            @req = Net::HTTP::Post.new(@uri.request_uri)

        when HTTP_PUT then
            @req = Net::HTTP::Put.new(@uri.request_uri)

        when HTTP_DELETE then
            @req = Net::HTTP::Delete.new(@uri.request_uri)

        end
    end

    def setContentType(value)
        @req["Content-Type"] = value
    end

    def setHeader(key, value)
        @req[key] = value
    end

    def setKiiHeader(context, authRequired)
        setHeader('x-kii-appid', context.appId)
        setHeader('x-kii-appkey', context.appKey)
        if authRequired then
            setHeader('authorization', 'bearer ' + context.accessToken)
        end
    end

    def sendFile(fp)
        @req.body = fp
        send()
    end

    def sendForDownload(fp)
        @req.attach(KiiHttpClientObserver.new(fp))
		send()
    end

    def sendJson(json)
        body = JSON.generate(json)
        @req.body = body
        send()
    end

    def send()
        @http = Net::HTTP.new(@uri.host, @uri.port)
        @http.use_ssl = true

        # @http.set_debug_output $stderr
        # puts "\n"

        resp = @http.request(@req)

        return KiiHttpResponse.new(resp.code, resp, resp.body)

        rescue => e
            puts [@uri.to_s, e.class, e].join(" : ")
            nil
    end
end
