class ContributionsController < ApplicationController
  def index
    @contribution = Contribution.all
  end

  def show
    @contribution = Contribution.find(params[:id])
  end

  def new
    @contribution = Contribution.new
    @contreparties = Contrepartie.all
    @user = current_user
    @project = params[:project_id]
  end

  def create
    @contreparties = Contrepartie.all
    @contribution = Contribution.new(contribution_params)

    transaction = CreateContribution.new.call(contribution: @contribution)
    if transaction.success?
      @contribution.project.update_attributes(percentage: @contribution.project.percentage_of_completion)
      redirect_to contribution_path(@contribution.id)
    else
      @contribution = transaction.failure[:resource]
      render :new
    end
  end

  private

  def contribution_params
    params.require(:contribution).permit(:amount, :user_id, :project_id, :contrepartie_id)
  end
end
