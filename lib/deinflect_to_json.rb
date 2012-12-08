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
      from_suffix = parts.first
      reason_id = parts[3].to_i
      rules_hash[from_suffix.size] ||= []
      rules_hash[from_suffix.size] << {
        :from_suffix => from_suffix,
        :to_suffix => parts[1],
        :reason => reasons[reason_id],
      }
    end
  end
  rules_hash
end

root = File.expand_path(File.dirname(__FILE__))
File.open(File.join(root, 'data/deinflect.json'), 'w') do |f|
  parsed_dat = parse(File.join(root, 'data/deinflect.dat'))
  f.write(JSON.pretty_generate(parsed_dat))
end
