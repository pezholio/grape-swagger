module GrapeSwagger
  class ModelParsers
    include Enumerable

    def initialize
      @parsers = {}
    end

    def register(klass, ancestor)
      @parsers[klass] = ancestor.to_s
    end

    def insert_before(before_klass, klass, ancestor)
      subhash = @parsers.except(klass).to_a
      insert_at = subhash.index(subhash.assoc(before_klass))
      insert_at = subhash.length - 1 if insert_at.nil?
      @parsers = Hash[subhash.insert(insert_at, [klass, ancestor])]
    end

    def insert_after(after_klass, klass, ancestor)
      subhash = @parsers.except(klass).to_a
      insert_at = subhash.index(subhash.assoc(after_klass))
      insert_at = subhash.length - 1 if insert_at.nil?
      @parsers = Hash[subhash.insert(insert_at + 1, [klass, ancestor])]
    end

    def each
      @parsers.each_pair do |klass, ancestor|
        yield klass, ancestor
      end
    end
  end
end
