module PresentationsHelper
	def open_new_presentations?
		DateTime.now < Date.strptime('20140615','%Y%m%d')
	end
end
