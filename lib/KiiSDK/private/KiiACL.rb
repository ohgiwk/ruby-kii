class KiiACL

    QUERY_OBJECTS_IN_BUCKET = 1
    CREATE_OBJECTS_IN_BUCKE = 2
    DROP_BUCKET_WITH_ALL_CONTENT = 3



    attr_reader :path

    def initialize(action, subject)

        @path = "acl/#{action}/UserID:{USER_ID_2}"

    end




end
