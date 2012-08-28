#encoding: utf-8
require 'json'

class JapaneseDeinflector
  def initialize
    File.open(File.join(File.expand_path(File.dirname(__FILE__)), 'data/deinflect.json')) do |f|
      rules_and_reasons = JSON.parse(f.read, :symbolize_names => true)
      @reasons = rules_and_reasons[:reasons]
      # Convert hash keys to integers
      @rules = {}
      # Convert hash keys from something like :"9" -> 9
      rules_and_reasons[:rules].each do |size, rules|
        @rules[size.to_s.to_i] = rules
      end
    end
  end

  def deinflect(word)
    possibilities = []
    rules_less_than_size(word.size).each do |size, rules|
      ending = word[-size..-1]
      rules.each do |rule|
        next  unless ending == rule[:from]
        new_word = "#{word[0..-size-1]}#{rule[:to]}"
        next  if possibilities.include?(new_word)
        # Weight is between 0 and 1, 1 being a higher chance of actual deinflection
        weight = (Float(size) / word.size).round(3)
        reason = @reasons[rule[:reason_id]]
        possibilities << {weight: weight, word: new_word, reason: reason}
      end
    end
    possibilities
  end

  private

  def rules_less_than_size(max_size)
    @rules.clone.keep_if{|size, rules| size < max_size}
  end
end
