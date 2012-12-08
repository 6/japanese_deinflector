#encoding: utf-8
require 'spec_helper'

describe JapaneseDeinflector do
  subject{ JapaneseDeinflector.new }

  describe "verbs" do
    context "in present / attibutive tense" do

      it "does not deinflect plain positive (non-inflected) verbs" do
        subject.deinflect("見る").should be_empty
        subject.deinflect("歌う").should be_empty
      end

      it "deinflects polite positive verbs" do
        subject.deinflect("見ます").first[:word].should == "見る"
        subject.deinflect("歌います").first[:word].should == "歌う"
      end

      it "deinflects plain negative verbs" do
        subject.deinflect("見ない").first[:word].should == "見る"
        subject.deinflect("歌わない").first[:word].should == "歌う"
      end

      it "deinflects polite negative formal verbs" do
        subject.deinflect("見ません").first[:word].should == "見る"
        subject.deinflect("歌いません").first[:word].should == "歌う"
      end

    end

    context "in progressive (ongoing) tense" do

      it "deinflects plain positive verbs" do
        pending "unimplemented"

        subject.deinflect("見ている").first[:word].should == "見る"
        subject.deinflect("歌っている").first[:word].should == "歌う"
      end

      it "deinflects polite positive verbs" do
        pending "unimplemented"

        subject.deinflect("見ています").first[:word].should == "見る"
        subject.deinflect("歌っています").first[:word].should == "歌う"
      end

      it "deinflects plain negative verbs" do
        pending "unimplemented"

        subject.deinflect("見ていない").first[:word].should == "見る"
        subject.deinflect("歌っていない").first[:word].should == "歌う"
      end

      it "deinflects polite negative formal verbs" do
        pending "unimplemented"

        subject.deinflect("見ていません").first[:word].should == "見る"
        subject.deinflect("歌っていません").first[:word].should == "歌う"
      end

    end

    context "in past / present-perfect tense" do

      it "deinflects plain positive verbs" do
        subject.deinflect("見た").first[:word].should == "見る"
        subject.deinflect("歌った").first[:word].should == "歌う"
      end

      it "deinflects polite positive verbs" do
        subject.deinflect("見ました").first[:word].should == "見る"
        subject.deinflect("歌いました").first[:word].should == "歌う"
      end

      it "deinflects plain negative verbs" do
        pending "unimplemented"

        subject.deinflect("見なかった").first[:word].should == "見る"
        subject.deinflect("歌わなかった").first[:word].should == "歌う"
      end

      it "deinflects polite negative formal verbs" do
        subject.deinflect("見ませんでした").first[:word].should == "見る"
        subject.deinflect("歌いませんでした").first[:word].should == "歌う"
      end

    end

    context "presumptive verbs" do

      it "deinflects plain verbs" do
        subject.deinflect("見よう").first[:word].should == "見る"
        subject.deinflect("歌おう").first[:word].should == "歌う"
        subject.deinflect("走ろう").first[:word].should == "走る"
      end

      it "deinflects polite verbs" do
        subject.deinflect("見ましょう").first[:word].should == "見る"
        subject.deinflect("歌いましょう").first[:word].should == "歌う"
        subject.deinflect("走りましょう").first[:word].should == "走る"
      end

    end

    context "imperative verbs" do

      it "deinflects plain positive verbs" do
        subject.deinflect("見ろ").first[:word].should == "見る"
        subject.deinflect("歌え").first[:word].should == "歌う"
        subject.deinflect("走れ").first[:word].should == "走る"
      end

      it "deinflects plain negative verbs" do
        subject.deinflect("見るな").first[:word].should == "見る"
        subject.deinflect("歌うな").first[:word].should == "歌う"
        subject.deinflect("走るな").first[:word].should == "走る"
      end

    end

    context "provisional verbs" do

      it "deinflects positive verbs" do
        subject.deinflect("見れば").first[:word].should == "見る"
        subject.deinflect("歌えば").first[:word].should == "歌う"
      end

      it "deinflects negative verbs" do
        pending "unimplemented"

        subject.deinflect("見なければ").first[:word].should == "見る"
        subject.deinflect("歌えなければ").first[:word].should == "歌う"
      end

    end

    context "in conditional form" do

      it "deinflects plain positive verbs" do
        subject.deinflect("見たら").first[:word].should == "見る"
        subject.deinflect("歌ったら").first[:word].should == "歌う"
      end

      it "deinflects plain negative verbs" do
        pending "unimplemented"

        subject.deinflect("見なかったら").first[:word].should == "見る"
        subject.deinflect("歌わなかったら").first[:word].should == "歌う"
      end

      it "deinflects polite positive verbs" do
        pending "unimplemented"

        subject.deinflect("見ましたら").first[:word].should == "見る"
        subject.deinflect("歌いましたら").first[:word].should == "歌う"
      end

    end
  end

  describe "adjectives" do
    it "deinflects adjectives in present tense" do
      subject.deinflect("嬉しくありません").first[:word].should == "嬉しい"
    end

    it "deinflects adjectives in past tense" do
      subject.deinflect("嬉しくありませんでした").first[:word].should == "嬉しい"
    end
  end
end
