class KiiUser

    attr_reader :id

    def initialize(id)
        @id = id
    end

    def getPath()
        return "/users/" + @id
    end

end
