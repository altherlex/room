require 'spec_helper'

describe ReservesHelper do
	include Devise::TestHelpers
	helper ApplicationHelper

	before{ 
		@user = FactoryGirl.create :user
		@reserve = FactoryGirl.create(:reserve)
		@reserve.user_id = @user.id
		sign_in :user, @user
  }

  it "should return valid head table" do
  	(head_tag).should be_an_instance_of Array
  	expect(head_tag.size).to eq(6)
  end

  it "have only week" do
	date = Date.new(2014,1,1)
	expect( now(date).saturday? ).to eq(false)
    	date = Date.new(2014,1,2)
    	expect( now(date).sunday? ).to eq(false)
  end

  it "have return label about reserve" do
    	helper.label_with_elem(@reserve).should be_an_instance_of Array
  end

  it "reserve_tag" do
        helper.reserve_tag(Date.current, Time.now.hour).should be_an_instance_of String
  end

end
