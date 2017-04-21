class GoalsController < ApplicationController
  def new
    @goal = Goal.new
    render :new
  end


  def create
    @goal = Goal.new(goal_params)

    if @goal.save
      render :show
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
    render :edit
  end

  def update
    @goal = Goal.find_by(id: params[:id])

    if @goal.update_attributes(goal_params)
      render :show
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end


  def destroy
    @goal = Goal.find_by(id: params[:id])
    user_id = @goal.user_id
    @goal.destroy
    redirect_to user_url(user_id)
  end

  def show
    render :show
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :user_id, :status, :visibility)
  end
end
