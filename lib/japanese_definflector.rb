class JapaneseDeinflector
  def initialize(fpath)
    @rules = []
    @reasons = []
    parse(fpath)
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
        possibilities << {weight: weight, word: new_word, reason: rule[:reason]}
      end
    end
    possibilities
  end

  private

  def parse(fpath)
    prev_from_size = nil
    rules_hash = {}
    File.open(fpath).each_with_index do |line, i|
      next  if i == 0 # Skip header
      parts = line.strip.split(/\t/)
      # Reasons are listed at the top of the file and are not tab-separated
      if parts.size == 1
        @reasons << parts[0]
      # Rules are tab-separated in the following format:
      # <from>\t<to>\t<type>\t<reason_index>
      else
        from, to, type, reasons_index = parts[0], parts[1], parts[2].to_i, parts[3].to_i
        rules_hash[from.size] ||= {:size => from.size, :rules => []}

        rules_hash[from.size][:rules] << {
          :from => from,
          :to => to,
          :type => type,
          :reason => @reasons[reasons_index]
        }
      end
    end

    # Sort <from> in descending order by size, since we check <from> from largest to smallest
    @rules = rules_hash.values.sort{|x, y| y[:size] <=> x[:size]}
  end
end
