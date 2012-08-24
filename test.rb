#encoding: utf-8
require './lib/japanese_definflector'

jd = JapaneseDeinflector.new
puts jd.deinflect("歌った")
puts jd.deinflect("嬉しくありません")
