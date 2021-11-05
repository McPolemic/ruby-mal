require_relative 'spec_helper'
require_relative '../step2_eval'

RSpec.describe 'Step2' do
  it '(+ 1 2)' do
    expect(run('(+ 1 2)')).to eq "3"
  end

  it '(+ 5 (* 2 3))' do
    expect(run('(+ 5 (* 2 3))')).to eq "11"
  end

  it '(- (+ 5 (* 2 3)) 3)' do
    expect(run('(- (+ 5 (* 2 3)) 3)')).to eq "8"
  end

  it '(/ (- (+ 5 (* 2 3)) 3) 4)' do
    expect(run('(/ (- (+ 5 (* 2 3)) 3) 4)')).to eq "2"
  end

  it '(/ (- (+ 515 (* 87 311)) 302) 27)' do
    expect(run('(/ (- (+ 515 (* 87 311)) 302) 27)')).to eq "1010"
  end

  it '(* -3 6)' do
    expect(run('(* -3 6)')).to eq "-18"
  end

  it '(/ (- (+ 515 (* -87 311)) 296) 27)' do
    expect(run('(/ (- (+ 515 (* -87 311)) 296) 27)')).to eq "-994"
  end

  # This should throw an error with no return value
  it '(abc 1 2 3)' do
    expect { run('(abc 1 2 3)') }.to raise_error "'abc' not found"
  end

  # Testing empty list
  it '()' do
    expect(run('()')).to eq "()"
  end

  context "Deferrable functionality" do
    context "Testing evaluation within collection literals" do
      it '[1 2 (+ 1 2)]' do
        expect(run('[1 2 (+ 1 2)]')).to eq '[1 2 3]'
      end

      it '{"a" (+ 7 8)}' do
        expect(run('{"a" (+ 7 8)}')).to eq '{"a" 15}'
      end

      it '{:a (+ 7 8)}' do
        expect(run('{:a (+ 7 8)}')).to eq '{:a 15}'
      end
    end

    context "Check that evaluation hasn't broken empty collections" do
      it '[]' do
        expect(run('[]')).to eq '[]'
      end

      it '{}' do
        expect(run('{}')).to eq '{}'
      end
    end
  end
end
