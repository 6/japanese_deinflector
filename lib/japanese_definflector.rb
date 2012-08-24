#encoding: utf-8
require 'json'

class JapaneseDeinflector
  def initialize
    File.open(File.join(File.expand_path(File.dirname(__FILE__)), 'data/deinflect.json')) do |f|
      rules_and_reasons = JSON.parse(f.read, :symbolize_names => true)
      @rules = rules_and_reasons[:rules]
      @reasons = rules_and_reasons[:reasons]
    end
  end

  def deinflect(word)
    possibilities = []

    @rules.each do |rules_of_given_size|
      size = rules_of_given_size[:size]
      next  unless size <= word.size
      ending = word[-size..-1]
      rules_of_given_size[:rules].each do |rule|
        next  unless ending == rule[:from]
        new_word = "#{word[0..-size-1]}#{rule[:to]}"
        next  if new_word.empty? || possibilities.include?(new_word)
        # Weight is between 0 and 1, 1 being a higher chance of actual deinflection
        weight = (Float(size) / word.size).round(3)
        reason = @reasons[rule[:reason_id]]
        possibilities << {weight: weight, word: new_word, reason: reason}
      end
    end
    possibilities
  end
end
