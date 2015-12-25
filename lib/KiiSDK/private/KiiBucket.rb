class KiiBucket

    attr_reader :scope
    attr_reader :id
    attr_reader :name
    attr_reader :path

    SCOPE_APPLICATION = 1
    SCOPE_GROUP = 2
    SCOPE_USER = 3
    SCOPE_THINGS = 4

    def initialize(bucket_id, scope, id)

        @name = bucket_id
        @scope = scope
        @id = id

        case scope
        when SCOPE_APPLICATION
            @path = "/buckets/#{bucket_id}"

        when SCOPE_GROUP
            @path = "/groups/#{id}/buckets/#{bucket_id}"

        when SCOPE_USER
            @path = "/users/me/buckets/#{bucket_id}"

        when SCOPE_THINGS
            @path = "/things/#{id}/buckets/#{bucket_id}"
        end
    end

    def getPath
        @path
    end
end
