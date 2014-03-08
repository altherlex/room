class Reserve < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates_uniqueness_of :date, :scope=>:user_id

	def self.load(date, user_id)
		Reserve.where(date:date, user_id:user_id).first
	end
	def create_event!
		reserve = Reserve.load(self.date, self.user_id)
		# Destoy if exists
		if reserve
			reserve.destroy
		else
			self.save!
		end
	end
end
