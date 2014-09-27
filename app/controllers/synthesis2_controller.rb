class Synthesis2Controller < ApplicationController
  def new
  	@presentation = Presentation.find params[:presentation_id]
  	@presentation.build_synthesis2
  end

  def create
  	@presentation = Presentation.find params[:presentation_id]
    @synthesis = Synthesis.new(synthesis_params)
    @synthesis.date_due = Date.today
    respond_to do |format|
      if @synthesis.save
        @presentation.synthesis2 = @synthesis
        @presentation.save
        format.html { redirect_to @presentation, notice: 'Synthesis was successfully created.' }
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
