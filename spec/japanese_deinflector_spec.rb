#encoding: utf-8
require 'spec_helper'

describe JapaneseDeinflector do
  subject{ JapaneseDeinflector.new }

  it "deinflects plain positive verbs" do
    # progressive tense
    #subject.deinflect("見ている").first[:word].should == "見る"
    #subject.deinflect("歌っている").first[:word].should == "歌う"

    # past tense
    subject.deinflect("見た").first[:word].should == "見る"
    subject.deinflect("歌った").first[:word].should == "歌う"
  end

  it "deinflects polite positive verbs" do
    # present tense
    subject.deinflect("見ます").first[:word].should == "見る"
    subject.deinflect("歌います").first[:word].should == "歌う"

    # progressive tense
    #subject.deinflect("見ています").first[:word].should == "見る"
    #subject.deinflect("歌っています").first[:word].should == "歌う"

    # past tense
    subject.deinflect("見ました").first[:word].should == "見る"
    subject.deinflect("歌いました").first[:word].should == "歌う"
  end

  it "deinflects plain negative verbs" do
    # present tense
    subject.deinflect("見ない").first[:word].should == "見る"
    subject.deinflect("歌わない").first[:word].should == "歌う"

    # progressive tense
    #subject.deinflect("見ていない").first[:word].should == "見る"
    #subject.deinflect("歌っていない").first[:word].should == "歌う"

    # past tense
    #subject.deinflect("見なかった").first[:word].should == "見る"
    #subject.deinflect("歌わなかった").first[:word].should == "歌う"
  end

  it "deinflects polite negative formal verbs" do
    # present tense
    subject.deinflect("見ません").first[:word].should == "見る"
    subject.deinflect("歌いません").first[:word].should == "歌う"

    # progressive tense
    #subject.deinflect("見ていません").first[:word].should == "見る"
    #subject.deinflect("歌っていません").first[:word].should == "歌う"

    # past tense
    subject.deinflect("見ませんでした").first[:word].should == "見る"
    subject.deinflect("歌いませんでした").first[:word].should == "歌う"
  end

  it "deinflects polite negative formal adjectives" do
    # present tense
    subject.deinflect("嬉しくありません").first[:word].should == "嬉しい"

    # past tense
    subject.deinflect("嬉しくありませんでした").first[:word].should == "嬉しい"
  end

  it "deinflects plain presumptive verbs" do
    subject.deinflect("見よう").first[:word].should == "見る"
    subject.deinflect("歌おう").first[:word].should == "歌う"
  end

  it "deinflects polite presumptive verbs" do
    subject.deinflect("見ましょう").first[:word].should == "見る"
    subject.deinflect("歌いましょう").first[:word].should == "歌う"
  end

  it "deinflects plain positive imperative verbs" do
    subject.deinflect("見ろ").first[:word].should == "見る"
    subject.deinflect("歌え").first[:word].should == "歌う"
    subject.deinflect("走れ").first[:word].should == "走る"
  end

  it "deinflects plain negative imperative verbs" do
    subject.deinflect("見るな").first[:word].should == "見る"
    subject.deinflect("歌うな").first[:word].should == "歌う"
    subject.deinflect("走るな").first[:word].should == "走る"
  end
end
