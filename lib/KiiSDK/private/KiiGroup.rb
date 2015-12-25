class KiiGroup

    attr_reader :id
    attr_reader :name
    attr_reader :owner

    def initialize(id, name, owner)
        @id = id
        @name = name
        @owner = owner
    end

    def getPath
        return 'groups/' + @name
    end
end
