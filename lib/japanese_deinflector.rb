#encoding: utf-8
require 'rubygems'
require 'json'
require "japanese_deinflector/version"

class JapaneseDeinflector
  def initialize
    File.open(File.join(File.expand_path(File.dirname(__FILE__)), 'data/deinflect.json')) do |f|
      rules = JSON.parse(f.read, :symbolize_names => true)
      # Convert hash keys to integers (from something like :"9" -> 9)
      @rules = {}
      rules.each do |size, rules|
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
        deinflected_word = "#{word[0..-size-1]}#{rule[:to]}"
        next  if possibilities.include?(deinflected_word)
        # Weight is between 0 and 1, 1 being a higher chance of actual deinflection
        weight = (Float(size) / word.size).round(3)
        possibilities << {:weight => weight, :word => deinflected_word, :reason => rule[:reason]}
      end
    end
    possibilities
  end

  private

  def rules_less_than_size(max_size)
    @rules.clone.delete_if{|size, rules| size >= max_size}
  end
end
