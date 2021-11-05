require_relative 'spec_helper'
require_relative '../step1_read_print'

RSpec.describe 'Step1' do
  context 'Testing read of numbers' do
    it '1' do
      expect(run('1')).to eq '1'
    end
    it '7' do
      expect(run('7')).to eq '7'
    end
    it '7   ' do
      expect(run('7   ')).to eq '7'
    end
    it '-123' do
      expect(run('-123')).to eq '-123'
    end
  end
end
