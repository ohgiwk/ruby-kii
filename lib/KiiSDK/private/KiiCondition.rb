require_relative './KiiClause.rb'

class KiiCondition

    def initialize(clause)
        @clause = clause
    end


    def sortByAsc(field)
        @orderBy = field
        @descending = FALSE
    end


    def sortByDesc(field)
        @orderBy = field
        @descending = TRUE
    end


    def setLimit(limit)
        @limit = limit
    end


    def setPaginationKey(key)
        @paginationKey = key
    end


    def hasNext()
        return @paginationKey != nil
    end

    def toJson()
        query = {
            :clause => @clause.toJson()
        }

        if @orderBy
            query['orderBy'] = @orderBy
            query['descending'] = @descending
        end

        json = {:bucketQuery => query}

        if @limit
            json['bestEffortLimit'] = @limit
        end

        if @paginationKey
            json['paginationKey'] = @paginationKey
        end

        return json
    end
end
