module Pegasus
  module Atoms
    class String < Base
      getter :str

      def initialize(@str : ::String)
        @label = :string
      end

      def match?(context : Context)
        if context.rest.size >= @str.size && context.rest.starts_with?(@str)
          node = Pegasus::Leaf(::String).new(@label, @str)
          {MatchResult.success(node), context.consume(@str)}
        else
          node = Pegasus::Leaf(::String).new(@label, @str)
          error = Pegasus::ParseError.with_details(@str, context.rest, context.pos)
          {MatchResult.failure(node, error), context}
        end
      end

      def ==(other : String)
        @str == other.str
      end
    end
  end
end
