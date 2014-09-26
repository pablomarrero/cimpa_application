class Synthesis1Controller < ApplicationController
  def new
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer_admin) || (@presentation.evaluator1==current_user || @presentation.evaluator2==current_user)

    @presentation.build_synthesis1
  end

  def create
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer_admin) || (@presentation.evaluator1==current_user || @presentation.evaluator2==current_user)

    @synthesis = Synthesis.new(synthesis_params)
    @synthesis.date_due = Date.today
    respond_to do |format|
      if @synthesis.save
        @presentation.synthesis1 = @synthesis
        @presentation.save
        format.html { redirect_to @presentation, notice: 'Synthesis was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  def edit
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer_admin) || (@presentation.evaluator1==current_user || @presentation.evaluator2==current_user)
  end

  def update
    @presentation = Presentation.find params[:presentation_id]
    return redirect_to('/') unless current_user.has_any_role?(:admin, :scientific_officer_admin) || (@presentation.evaluator1==current_user || @presentation.evaluator2==current_user)

    @synthesis = Synthesis.find params[:id]
    respond_to do |format|
      if @synthesis.update(synthesis_params)
        format.html { redirect_to @presentation, notice: 'Synthesis was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def synthesis_params
      params.require(:synthesis).permit(:summary, :comment)
    end
end
