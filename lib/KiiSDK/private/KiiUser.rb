class KiiUser

    attr_reader :id
    attr_accessor :data

    def initialize(id)
        @id = id
    end

    def getPath
        return "/users/" + @id
    end
end
