class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = current_user.exercises.order(date_time: :desc)
  end

  def show
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)
    exercise_type = ExerciseType.find(@exercise.exercise_type_id)
    @exercise.calories_burned = @exercise.duration * exercise_type.calories_per_minute
  
    if @exercise.save
      # 保存成功時の処理
      flash[:success] = "Exercise was successfully added!" # ユーザーにメッセージを表示
      redirect_to exercises_path # 例えば、全ての運動のリストへリダイレクト
    else
      # 保存失敗時の処理
      flash.now[:danger] = "There was an error adding the exercise. Please try again." # 現在のページにエラーメッセージを表示
      render 'new' # 新規作成フォームを再表示
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to exercise_path(@exercise), notice: 'Exercise was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercises_path, notice: 'Exercise was successfully deleted.'
  end

  def calculate_calories
    exercise_type = ExerciseType.find(params[:exercise_type_id])
    duration = params[:duration].to_i
  
    calories_per_minute = exercise_type.calories_per_minute # You'll need to add this attribute or method to your ExerciseType model.
    calories_burned = calories_per_minute * duration
  
    render json: { calories_burned: calories_burned }
  end

  private

  def set_exercise
    @exercise = current_user.exercises.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:exercise_type_id, :duration, :calories_burned, :date_time)
  end
end
