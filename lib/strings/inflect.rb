# frozen_string_literal: true

require "set"

require_relative "inflect/nouns"
require_relative "inflect/version"

module Strings
  module Inflect
    # Check if word is uncountable
    #
    # @param [String] word
    #   the word to check
    #
    # @return [Boolean]
    #
    # @api private
    def uncountable?(word)
      Nouns.uncountable.include?(word)
    end
    module_function :uncountable?

    # Inflect a noun into a correct form
    #
    # @example
    #   Strings::Inflect.inflect("error", 3)
    #   # => "errors"
    #
    # @param [String] word
    #   the word to inflect
    # @param [Integer] count
    #   the count of items
    #
    # @api public
    def inflect(word, count)
      if count == 1
        singularize(word)
      else
        pluralize(word)
      end
    end
    module_function :inflect

    # Inflect a pural word to its singular form
    #
    # @example
    #   Strings::Inflect.singularize("errors")
    #   # => "error"
    #
    # @param [String] word
    #   the noun to inflect to singular form
    #
    # @api public
    def singularize(word)
      return word if word.to_s.empty? || uncountable?(word)

      regex, replacement = Nouns.singulars.find { |rule| !!(word =~ rule[0]) }

      return word if regex.nil?

      word.sub(regex, replacement)
    end
    module_function :singularize

    # Inflect singular noun into plural
    #
    # @example
    #   Strings::Inflect.pluralize("error")
    #   # => "errors"
    #
    # @param [String] word
    #   noun to inflect to plural form
    #
    # @api public
    def pluralize(word)
      return word if word.to_s.empty? || uncountable?(word)

      regex, replacement = Nouns.plurals.find { |rule| !!(word =~ rule[0]) }

      return word if regex.nil?

      word.sub(regex, replacement)
    end
    module_function :pluralize

    # Check if noun is in singular form
    #
    # @example
    #   Strings::Inflect.singular?("error")
    #   # => true
    #
    # @return [Boolean]
    #
    # @api public
    def singular?(string)
      return false if string.to_s.empty?

      string == singularize(string)
    end
    module_function :singular?

    # Check if noun is in plural form
    #
    # @example
    #   Strings::Inflect.plural?("errors")
    #   # => true
    #
    # @return [Boolean]
    #
    # @api public
    def plural?(string)
      return false if string.to_s.empty?

      string == pluralize(string)
    end
    module_function :plural?

    WHITESPACE_REGEX = /(\s)\s+/.freeze

    # Join a list of words into a single sentence
    #
    # @example
    #   Strings::Inflect.join_words("one", "two", "three")
    #   # => "one, two and three"
    #
    # @param [Array[String]] words
    #   the words to join
    # @param [String] separator
    #   the character to use to join words, defaults to `,`
    # @param [String] final_separator
    #   the separator used before joining the last word
    # @param [String] conjunctive
    #   the word used for combining the last word with the rest
    #
    # @return [String]
    #
    # @api public
    def join_words(*words, separator: ", ", conjunctive: "and", final_separator: nil)
      oxford_comma = final_separator || separator

      case words.length
      when 0
        ""
      when 1, 2
        words.join(" #{conjunctive} ").gsub(WHITESPACE_REGEX, "\\1")
      else
        ((words[0...-1]).join("#{separator}") +
         "#{oxford_comma} #{conjunctive} " + words[-1])
          .gsub(WHITESPACE_REGEX, "\\1").gsub(/\s*(,)/, "\\1")
      end
    end
    module_function :join_words
  end # Inflect
end # Strings
