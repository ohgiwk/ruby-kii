class KiiTopic

    attr_reader :name

    def initialize(owner, name)
        @owner = owner
        @name = name
    end

    def getPath
        @owner.getPath + '/topics/' + @name
    end
end
