class MessageEvaluatorMailer < ActionMailer::Base
	default from: "info@cimpa.info"

	def send_notification presentation, evaluator
		@presentation = presentation		
		@user = evaluator	
  	mail(to: @user.email, subject: 'Please fill your assigned  evaluations of projects.')
  end
end