require_relative './KiiGCMMessage.rb'
require_relative './KiiAPNsMessage.rb'

class KiiTopicMessage
    attr_accessor :data
    attr_writer :sendToDevelopment
    attr_writer :sendToProduction
    attr_writer :pushMessageType
    attr_writer :sendAppID
    attr_writer :sendSender
    attr_writer :sendWhen
    attr_writer :sendOrigin
    attr_writer :sendObjectScope
    attr_writer :sendTopicID
    attr_accessor :gcm
    attr_accessor :apns

    def initialize()
        @data = []
        @sendToDevelopment = true
        @sendToProduction = true
        @pushMessageType = ''
        @sendAppID = false
        @sendSender = true
        @sendWhen = false
        @sendOrigin = false
        @sendObjectScope = true
        @sendTopicID = true

        @gcm = KiiGCMMessage.new()
        @apns = KiiAPNsMessage.new()
    end

    def toJson
        json = array(
            :sendToDevelopment => @sendToDevelopment,
            :sendToProduction => @sendToProduction,
            :pushMessageType => @pushMessageType,
            :sendAppID => @sendAppID,
            :sendSender => @sendSender,
            :sendWhen => @sendWhen,
            :sendOrigin => @sendOrigin,
            :sendObjectScope => @sendObjectScope,
            :sendTopicID => @sendTopicID,
            :gcm => @gcm.toJson(),
            :apns => @apns.toJson()
        )
        if @data.length > 0
            json['data'] = @data
        end
        return json
    end
end
