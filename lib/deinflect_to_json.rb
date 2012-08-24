#encoding: utf-8
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
      from = parts.first
      rules_hash[from.size] ||= []
      rules_hash[from.size] << {
        :from => from,
        :to => parts[1],
        :reason_id => parts[3].to_i
      }
    end
  end

  {:reasons => reasons, :rules => rules_hash}
end

root = File.expand_path(File.dirname(__FILE__))
File.open(File.join(root, 'data/deinflect.json'), 'w') do |f|
  f.write(parse(File.join(root, 'data/deinflect.dat')).to_json)
end
