require 'spec_helper'

describe Reserve do
	it { should have_db_column(:date).of_type(:datetime) }
	it { should belong_to(:user) }

	let(:user) { create(:user) }
	
	#before { @reserve = FactoryGirl.create :reserve }
 	it "should reserve the room for an user" do
  	first_reserve = Reserve.new(date: DateTime.current, user_id: user.id)
    expect(first_reserve.valid?).to eq(true)
		Reserve.create!(date: DateTime.current, user_id: user.id).should be_an_instance_of Reserve
  end

 	before{ @reserve = FactoryGirl.create(:reserve) }
 	it "should avoid duplicate" do
 		@reserve.should be_an_instance_of Reserve
  	reserve = Reserve.new(date: @reserve.date, user_id: @reserve.user_id)
    expect(reserve.valid?).to eq(false)
  end

  it "should load" do
  	r = Reserve.load(@reserve.date, @reserve.user_id)
  	r.should be_an_instance_of Reserve
	end

	it "should destroy if a reserve exist or create if there isn't" do
		# first destroy
		@reserve.create_event!.should be_an_instance_of Reserve
		# after create
		expect(@reserve.create_event!).to eq(true)
	end
end
