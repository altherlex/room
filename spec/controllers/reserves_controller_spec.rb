require 'spec_helper'

describe ReservesController do
	#include Devise::TestHelpers

	before{ 
		@user = FactoryGirl.create :user
		@reserve = FactoryGirl.create(:reserve) 
	}

  describe "GET 'index' with no autorization" do
    it "should be not successful" do
      get :index
      response.should_not be_success
      expect(response).to be_redirect
    end
  end

  describe "GET 'book' with no autorization" do
    it "should be not successful" do
      get :book, year:Time.now.year, month:Time.now.month, day:Time.now.day, hour:Time.now.hour
      response.should_not be_success
      expect(response).to be_redirect
    end
  end

  describe "GET 'index'" do
  	#render_views

		before do
			sign_in :user, @user
			@user.should be_an_instance_of User
	  end

    it "should be successful" do
      get :index
      response.should be_success
		end
  end

  describe "GET 'book'" do
		before do
			sign_in :user, @user
			@user.should be_an_instance_of User
	  end

	 	it "should return 200 status code" do
			get :book, year:2014, month:3, day:10, hour:9
			expect(response.status).to eq(200)
	  end

		it "responds with JSON" do
			get :book, year:2014, month:3, day:10, hour:9
			firt_resquest = JSON.parse(response.body)
			firt_resquest.keys.should == ["id","label"]

			get :book, year:2014, month:3, day:10, hour:9
			JSON.parse(response.body).should_not == firt_resquest			
		end	  

		it "should return flash message" do
			get :book, year:2014, month:3, day:10, hour:9
			flash.should_not be_nil
		end

		it "have specific name to :id" do
			get :book, year:2014, month:3, day:10, hour:9
			( controller.params.keys.grep(/^year|month|day|hour/).empty? ).should ==false
			(controller.params[:year].size).should == 4
		end		
  end
end
