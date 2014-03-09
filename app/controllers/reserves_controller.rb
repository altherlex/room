class ReservesController < ApplicationController
	before_filter :authenticate_user!
  include ApplicationHelper

	def index
	end
	def show
	end

	def book
		date=DateTime.new(
			params[:year].to_i, 	
			params[:month].to_i,
			params[:day].to_i,
			params[:hour].to_i
		)
		reserve = Reserve.new(:date=>date, :user_id=>current_user.id)
		if reserve.create_event! == true
			flash[:notice]= "Booked to #{date.to_s(:short)}"
  	else
			flash[:warn]= "Available room to #{date.to_s(:short)}"
			reserve=nil
  	end
  	render json: {id:"#{params[:year]}_#{params[:month]}_#{params[:day]}_#{params[:hour]}", label:label_with_elem(reserve).first}, :status=> 200
  rescue => e
  	flash[:error]=e.message
  	render nothing:true,:status=> 423
  end
  # Simple action
  def feed
  	#Reserve.where(["date between ?, ?", Time.at params[:start], Time.at params[:end]])
  	render :json=>Reserve.all.map{|i| {title:i.user.email, start:i.date, end:(i.date+1.hour)}}
	end
end
