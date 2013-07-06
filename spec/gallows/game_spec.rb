require "spec_helper"

module Gallows
  describe Game do
    let(:output) { double('output').as_null_object }
    let(:input) { double('input').as_null_object }
    let(:game) { Game.new(output, input) }
    describe "#set_rand_word" do
      it "set the secret word" do
        game.set_rand_word.should_not be_nil
      end
    end
    describe "#check_letter" do
      before(:each) do
        game.stub(:set_rand_word).and_return("виселица")
        game.init
      end
      it "return false value" do
        game.check_letter("j").should == false
      end
      it "return true value" do
        game.check_letter("а").should == true
      end

    end
    describe "#procces" do
      before(:each) do
        #game.stub(:secret_word).and_return("nice")
        game.instance_variable_set(:@secret_word,"nice")
        game.instance_variable_set(:@errors,5)          
        #game.stub(:continue_game).and_return(false)
        
      end
      it "prompts please enter letter" do
        input.stub(:gets).and_return("j")
        game.init
        game.stub(:continue_game).and_return(false)
        output.should_receive(:puts).with('Please enter the letter')
        game.procces
      end
      it "open letter in public str" do
        
        game.instance_variable_set(:@public_str,"----")
        #game.stub(:continue_game).and_return(false)
        game.stub(:continue_game).and_return(false)
        input.stub(:gets).and_return("i")
        game.procces
        game.instance_variable_get(:@public_str).should == "-i--"
      end
      it "dont open letter in public str" do
        game.instance_variable_set(:@public_str,"----")
        input.stub(:gets).and_return("h")
        game.procces
        game.instance_variable_get(:@public_str).should == "----"
      end
      it "set @win true" do
        game.instance_variable_set(:@public_str,"n-ce")
        game.stub(:continue_game).and_return(false)
        input.stub(:gets).and_return("i")
        game.procces
        game.instance_variable_get(:@win).should == true
      end
    end
    describe "#run" do
      it "prompts win" do
        game.stub(:set_rand_word).and_return("vice")
        #game.instance_variable_set(:@secret_word,"vice")
        #game.instance_variable_set(:@errors,5)
        input.stub(:gets).and_return("v","i","c","e","n")
        var = game.instance_variable_get(:@public_str )
        output.should_receive(:puts).with(/Congratulations you WIN!!!!! secret word is #{var}/)
        game.run

      end
      it "prompts lose" do
        game.stub(:set_rand_word).and_return("vice")
        #game.instance_variable_set(:@secret_word,"nice")
        game.instance_variable_set(:@errors,5)
        game.instance_variable_set(:@public_str,"v-ce")
        input.stub(:gets).and_return("n")
        var = game.instance_variable_get(:@secret_word)
        output.should_receive(:puts).with(/You Lose! secret word is #{var}/)
        game.run
      end
    end
  end
end