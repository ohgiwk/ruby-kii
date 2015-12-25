require "KiiSDK/version"
require_relative "./KiiSDK/KiiAppAPI.rb"

module KiiSDK
  def initialize(appId, appKey, serverUrl)
    return KiiAppAPI.new(appId, appKey, serverUrl)
  end
end
