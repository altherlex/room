require 'spec_helper'

describe ReservesController do

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
      expect(response).to render_template("index")
    end
  
	 	it "should return 200 status code" do
			get :book
			expect(response.status).to eq(200)
	  end
  end
end
