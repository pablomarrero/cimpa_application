class Evaluation1Controller < ApplicationController
  def new
    @presentation = Presentation.find params[:presentation_id]

    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer_admin)
    return redirect_to('/') unless current_user.has_role?(:scientific_officer) && @presentation.evaluator1==current_user

    @presentation.build_evaluation1
  end

  def create
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer)
    return redirect_to('/') unless current_user.has_role?(:scientific_officer) && @presentation.evaluator1==current_user

    @evaluation = Evaluation.new(evaluation_params)
    @evaluation.date_due = Date.today
    respond_to do |format|
      if @evaluation.save
        @presentation.evaluation1 = @evaluation
        @presentation.save
        format.html { redirect_to @presentation, notice: 'Evaluation was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer)
    return redirect_to('/') unless current_user.has_role?(:scientific_officer) && @presentation.evaluator1==current_user
  end

  def update
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer)
    return redirect_to('/') unless current_user.has_role?(:scientific_officer) && @presentation.evaluator1==current_user

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
