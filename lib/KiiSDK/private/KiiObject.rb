class KiiObject

    attr_reader :id
    attr_accessor :version

    def initialize(bucket, id, data)
        @bucket = bucket
        @id = id
        @data = data
        @version = nil
    end

    def getPath()
        @bucket.getPath + '/objects/' + @id
    end

end
