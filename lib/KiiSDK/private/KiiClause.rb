class KiiClause
    attr_reader :clause
    @clause = {}

    def initialize(type)
        @clause = {:type => type}
    end

    def self.all
        KiiClause.new('all')
    end

    def self.equals(field, value)
        c = KiiClause.new('eq')
        c.clause['field'] = field
        c.clause['value'] = value

        return c
    end

    def self.greaterThan(field, value, included)
        c = KiiClause.new('range')
        c.clause['field'] = field
        c.clause['lowerLimit'] = value
        c.clause['lowerIncluded'] = included

        return c
    end

    def self.lessThan(field, value, included)
        c = KiiClause.new('range')
        c.clause['field'] = field
        c.clause['upperLimit'] = value
        c.clause['upperIncluded'] = included

        return c
    end

    def self.range(field, fromValue, fromInclude, toValue, toInclude)
        c = KiiClause.new('range')
        c.clause['field'] = field
        c.clause['lowerLimit'] = fromValue
        c.clause['lowerIncluded'] = fromInclude
        c.clause['upperLimit'] = toValue
        c.clause['upperIncluded'] = toInclude

        return c
    end

    def self.inClause(field, values)
        c = KiiClause('in')
        c.clause['field'] = field
        c.clause['values'] = values

        return c
    end

    def self.not(clause)
        c = KiiClause('not')
        c.clause['clause'] = clause.toJson()

        return c
    end

    def self.andClause(*clauses)
        c = KiiClause.new('and')
        array = KiiClause.toFlatArray(clauses)
        c.clause['clauses'] = array

        return c
    end

    def self.orClause(*clauses)
        c = KiiClause('or')
        array = KiiClause.toFlatArray(clauses)
        c.clause['clauses'] = array

        return c
    end

    def self.toFlatArray(args)
        array = []
        for arg in args do
            if arg.instance_of?(Array)
                for a in arg do
                    array.push(a.toJson())
                end
            else
                array.push(arg.toJson())
            end
        end

        return array
    end

    def toJson
        @clause
    end

end
