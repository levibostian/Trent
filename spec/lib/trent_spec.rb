# frozen_string_literal: true

require 'trent'

describe Trent do
  describe 'init' do
    it 'initializes without error. local instance' do
      trent = Trent.new(color: :light_blue, local: true)
      trent.sh('true')
    end
  end
end
