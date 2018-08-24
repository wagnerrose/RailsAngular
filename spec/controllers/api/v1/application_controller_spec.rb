require 'rails_helper'

RSpec.describe Api::V1::ApplicationController, type: :controller  do
  describe 'Includes the correct concerns' do
    it {expect(controller.class.ancestors).to include(Authenticable )}
  end
end
