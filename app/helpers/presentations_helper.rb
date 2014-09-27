module PresentationsHelper
	def open_pre_proposals?
		DateTime.now < Date.strptime('20140615','%Y%m%d')
	end
	def open_new_presentations?
		DateTime.now < Date.strptime('20141001','%Y%m%d')
	end
	def open_final_presentations?
		DateTime.now < Date.strptime('20141001','%Y%m%d')
	end
end
