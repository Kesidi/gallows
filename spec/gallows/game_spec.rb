require "spec_helper"

module Gallows
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:input) { double('input').as_null_object }
    let(:game) { Game.new(output, input) }
    context "start" do
      it "should say hi" do
        game.should_receive(:puts).with(/hi/i)
        game.start
      end
    end
    describe "#set_rand_word" do
      it "set the secret word" do
        game.set_rand_word
        game.secret_word.length.should_not be_nil
      end
      it "return public str" do
        game.set_rand_word.should == "-"*game.secret_word.length
      end
    end
    describe "#check_letter" do
      it "return false value" do
        game.set_rand_word
        game.check_letter("a").class.should == FalseClass
      end
      it "return true value" do
        game.secret_word = "виселица"
        game.public_str = "--------"
        game.check_letter("а").class.should == TrueClass

      end

    end
  end
end