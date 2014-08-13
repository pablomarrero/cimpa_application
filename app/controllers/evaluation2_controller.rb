class Evaluation2Controller < ApplicationController
  def new
  	@presentation = Presentation.find params[:presentation_id]
  	@presentation.build_evaluation2
  end

  def create
  	@presentation = Presentation.find params[:presentation_id]
    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.date_due = Date.today
    respond_to do |format|
      if @evaluation.save
        @presentation.evaluation2 = @evaluation
        @presentation.save
        format.html { redirect_to @presentation, notice: 'Evaluation was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
  	@presentation = Presentation.find params[:presentation_id]
  end

  def update
  	@presentation = Presentation.find params[:presentation_id]
  	@evaluation = Evaluation.find params[:id]
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.html { redirect_to @presentation, notice: 'Evaluation was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def evaluation_params
      params.require(:evaluation).permit(:organization, :standard, :suitability, :funding, :assessment, :report)
    end

end
