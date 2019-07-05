require "rspec/autorun"
class Word_wrap
  def self.wrap(string,length)
    result = ""
    while string.length > length
      break_index = length
      for char in 0...length do
        if string[char] == " "
          break_index = char
        end
      end
      result << string[0...break_index].strip << "\n"
      string = string[break_index..string.length].strip
    end

    if string.length <= length
      return result << string
    end
  end
end

describe Word_wrap do
  describe "wrap" do
    it "returns an empty string when given an empty string" do
      expect(Word_wrap.wrap("",5)).to eq("")
    end

    it "returns a word if its length is shorter than the given length" do
      expect(Word_wrap.wrap("kata",5)).to eq("kata")
    end

    it "returns a splitted string in case of a space" do
      expect(Word_wrap.wrap("word wrap",5)).to eq("word\nwrap")
    end

    it "returns a splitted string containing multiple words in case of a space" do
      expect(Word_wrap.wrap("word wrap kata",5)).to eq("word\nwrap\nkata")
    end

    it "returns a splitted string when there is a space following the given length" do
      expect(Word_wrap.wrap("word wrap",4)).to eq("word\nwrap")
    end

    it "returns a string with the maximum possible number of words on a line" do
      expect(Word_wrap.wrap("word wrap kata",10)).to eq("word wrap\nkata")
    end

    it "returns a splitted string when there is a space before the given length to avoid chopping the next word" do
      expect(Word_wrap.wrap("word wrap",7)).to eq("word\nwrap")
    end

    it "returns a string containing a chopped word when the word is longer than the given length" do
      expect(Word_wrap.wrap("longword",4)).to eq("long\nword")
    end

    it "returns a splitted string on many lines when a word is longer than 2 * given length" do
      expect(Word_wrap.wrap("longlongword",4)).to eq("long\nlong\nword")
    end
  end
end
