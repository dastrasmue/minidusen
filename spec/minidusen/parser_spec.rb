# encoding: utf-8

require 'spec_helper'

describe Minidusen::Parser do

  describe '.parse' do

    it 'should parse field tokens first, because they usually give maximum filtering at little cost' do
      query = Minidusen::Parser.parse('word1 field1:field1-value word2 field2:field2-value')
      query.collect(&:value).should == ['field1-value', 'field2-value', 'word1', 'word2']
    end

    it 'should not consider the dash to be a word boundary' do
      query = Minidusen::Parser.parse('Baden-Baden')
      query.collect(&:value).should == ['Baden-Baden']
    end

    it 'should parse umlauts and accents' do
      query = Minidusen::Parser.parse('field:åöÙÔøüéíÁ "ÄüÊçñÆ ððÿáÒÉ" pulvérisateur pędzić')
      query.collect(&:value).should == ['åöÙÔøüéíÁ', 'ÄüÊçñÆ ððÿáÒÉ', 'pulvérisateur', 'pędzić']
    end

  end

end
