#encoding: utf-8
require 'rubygems'
require 'json'
require "japanese_deinflector/version"

class JapaneseDeinflector
  def initialize
    File.open(File.join(File.expand_path(File.dirname(__FILE__)), 'data/deinflect.json')) do |f|
      rule_groups = JSON.parse(f.read, :symbolize_names => true)
      # Convert hash keys to integers (from something like :"9" -> 9)
      @rule_groups = {}
      rule_groups.each do |suffix_size, rules|
        @rule_groups[suffix_size.to_s.to_i] = rules
      end
    end
  end

  def deinflect(word)
    results = Set.new

    filter_rule_groups(@rule_groups, :max_suffix_size => word.size).each do |suffix_size, rules|
      from_suffix = word[-suffix_size..-1]
      filter_rules(rules, :from_suffix => from_suffix).each do |rule|
        results << result_hash(word, from_suffix, rule[:to_suffix], rule[:reason])
      end
    end

    results.to_a
  end

  private

  def result_hash(word, from_suffix, to_suffix, reason = "")
    # Append new suffix to the original word to get the deinflection
    deinflected_word = "#{word[0..-from_suffix.size-1]}#{to_suffix}"
    # Weight is between 0 and 1, 1 being a higher chance of correct deinflection
    weight = (Float(from_suffix.size) / word.size).round(3)
    {
      :word => deinflected_word,
      :weight => weight,
      :reason => reason,
    }
  end

  def filter_rule_groups(groups, filters = {})
    groups.clone.delete_if do |suffix_size, rules|
      suffix_size >= filters[:max_suffix_size]  if filters[:max_suffix_size]
    end
  end

  def filter_rules(rules, filters = {})
    rules.clone.delete_if.each do |rule|
      rule[:from_suffix] != filters[:from_suffix]  if filters[:from_suffix]
    end
  end
end
