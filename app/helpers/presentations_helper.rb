module PresentationsHelper
	def open_pre_proposals?
		DateTime.now < Date.strptime('20140615','%Y%m%d')
	end
	def open_new_presentations?
		DateTime.now < Date.strptime('20140815','%Y%m%d')
	end
	def open_final_presentations?
		DateTime.now < Date.strptime('20140815','%Y%m%d')
	end
	def need_modification? presentation
		need_modification1?(presentation) || need_modification2?(presentation)
	end
	def need_modification1? presentation
		(!presentation.modification1_date.nil? && presentation.modification1_req_date.nil?)
	end

	def need_modification2? presentation
		(!presentation.modification2_date.nil? && presentation.modification2_req_date.nil?)
	end

end
