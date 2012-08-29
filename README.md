Deinflect Japanese words. Ruby 1.9 or higher required.

[![Build Status](https://secure.travis-ci.org/6/japanese_deinflector.png?branch=master)](http://travis-ci.org/6/japanese_deinflector)

### Install

`gem install japanese_deinflector` or add `japanese_deinflector` to your Gemfile.

### Usage

```ruby
jd = JapaneseDeinflector.new
jd.deinflect("嬉しくありません")
```

This method returns an array of weighted possible deinflections, where a weight of 1 is highly likely to be the correct deinflection, and a weight of 0 is highly unlikely:

```ruby
[
  {:weight=>0.75, :word=>"嬉しい", :reason=>"polite negative"},
  {:weight=>0.5, :word=>"嬉しくある", :reason=>"polite negative"},
  {:weight=>0.375, :word=>"嬉しくありる", :reason=>"polite negative"}
]
```

Input text should be UTF-8 encoded.
