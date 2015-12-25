require "KiiSDK/version"
require_relative "./KiiSDK/KiiAppAPI.rb"

module KiiSDK
  def init(appId, appKey, serverUrl)
    return KiiAppAPI.new(appId, appKey, serverUrl)
  end

  module_function :init
end
