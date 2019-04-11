require 'rails_helper'

RSpec.describe Category do
  describe '#Category' do
    describe '#name' do
      it { should validate_presence_of(:name) }
    end
  end
end
