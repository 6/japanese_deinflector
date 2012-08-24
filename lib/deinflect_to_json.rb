require 'json'

def parse(fpath)
  reasons = []
  rules_hash = {}
  File.open(fpath).each_with_index do |line, i|
    next  if i == 0 # Skip header
    parts = line.strip.split(/\t/)
    # Reasons are listed at the top of the file and are not tab-separated
    if parts.size == 1
      reasons << parts[0]
    # Rules are tab-separated in the following format:
    # <from>\t<to>\t<type>\t<reason_index>
    else
      from, to, type, reasons_index = parts[0], parts[1], parts[2].to_i, parts[3].to_i
      rules_hash[from.size] ||= {:size => from.size, :rules => []}
      rules_hash[from.size][:rules] << {
        :from => from,
        :to => to,
        :type => type,
        :reason_id => reasons_index
      }
    end
  end

  # Sort <from> in descending order by size, since we check <from> from largest to smallest
  rules = rules_hash.values.sort{|x, y| y[:size] <=> x[:size]}
  {:reasons => reasons, :rules => rules}
end

root = File.expand_path(File.dirname(__FILE__))
File.open(File.join(root, 'data/deinflect.json'), 'w') do |f|
  f.write(parse(File.join(root, 'data/deinflect.dat')).to_json)
end
