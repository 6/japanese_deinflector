Deinflect Japanese words. Ruby 1.9 or higher required.

[![Build Status](https://secure.travis-ci.org/6/japanese_deinflector.png?branch=master)](http://travis-ci.org/6/japanese_deinflector)

### Install

`gem install japanese_deinflector` or add `japanese_deinflector` to your Gemfile.

### Usage

```ruby
jd = JapaneseDeinflector.new
p jd.deinflect("嬉しくありません")
# => [{:weight=>0.75, :word=>"嬉しい", :reason=>"polite negative"}, {:weight=>0.5, :word=>"嬉しくある", :reason=>"polite negative"}, {:weight=>0.375, :word=>"嬉しくありる", :reason=>"polite negative"}]
```

Input text should be UTF-8 encoded.
