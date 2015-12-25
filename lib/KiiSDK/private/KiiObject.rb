class KiiObject

    attr_reader :id
    attr_accessor :data
    attr_accessor :version

    def initialize(bucket, id, data)
        @bucket = bucket
        @id = id
        @data = data
        @version = nil
    end

    def getPath
        return @bucket.getPath + '/objects/' + @id
    end

end
