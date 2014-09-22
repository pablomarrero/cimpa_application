class EvaluatorsController < ApplicationController
  def index
  	@presentations_without_evaluator = Presentation.where("evaluator1_id is null or evaluator2_id is  null").page params[:page_presentations_without_evaluator]
  	@presentations_with_evaluator = Presentation.where("evaluator1_id is not null and evaluator2_id is not null").page params[:page_presentations_with_evaluator]
  	@evaluators = User.all.order(:email).select{|a| a.has_role? :scientific_officer }
  end

  def index_print
    @presentations_without_evaluator = Presentation.where("evaluator1_id is null or evaluator2_id is  null")
    @presentations_with_evaluator = Presentation.where("evaluator1_id is not null and evaluator2_id is not null")
    render layout: 'print'
  end
  def set_evaluator1
  	presentation = Presentation.find params[:presentation_id]
  	presentation.evaluator1 = User.find params[:evaluator]
  	presentation.save
  	redirect_to action: :index
  end

  def set_evaluator2
  	presentation = Presentation.find params[:presentation_id]
  	presentation.evaluator2 = User.find params[:evaluator]
  	presentation.save
  	redirect_to action: :index
  end

  def notificate_evaluator
    @presentation = Presentation.find params[:presentation_id]

    MessageEvaluatorMailer.send_notification(@presentation, @presentation.evaluator1).deliver unless @presentation.evaluator1.nil?
    MessageEvaluatorMailer.send_notification(@presentation, @presentation.evaluator2).deliver unless @presentation.evaluator2.nil?
    render :index, notice: 'Send Evaluators Notification Ok.'
  end
end
