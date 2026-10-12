module GoTransit
  module Inflector
    module_function

    def underscore(word)
      word.to_s.
        gsub(/(?<=[A-Z\d])(?=[A-Z][a-z])/, "_").
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr("-", "_").
        downcase
    end

    def pluralize(word)
      plural_of_singular(singularize(word))
    end

    def singularize(word)
      word = word.to_s
      return "#{word[0..-4]}y" if word.match?(/[^aeiou]ies\z/i)
      return word[0..-3] if word.match?(/(ss|x|z|ch|sh)es\z/i)
      return word[0..-2] if word.match?(/[^s]s\z/i) && !word.match?(/(us|is)\z/i)
      word
    end

    def plural_of_singular(singular)
      return singular if singular.empty?
      return "#{singular[0..-2]}ies" if singular.match?(/[^aeiou]y\z/i)
      return "#{singular}es" if singular.match?(/(s|x|z|ch|sh)\z/i)
      "#{singular}s"
    end
  end
end
