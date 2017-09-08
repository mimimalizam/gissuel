require "spec_helper"

RSpec.describe Gissuel do
  def app
    Gissuel
  end

  describe "POST todo" do
    it "returns status 200" do
      post "/gataway", :params => "hello rspec"

      expect(last_response.status).to eq 200
    end
  end
end
