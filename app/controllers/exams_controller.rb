class ExamsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_exam, only: [:show, :update]

  def create
    @exam = Exam.new exam_params
    if @exam.save
      flash[:success] = t "alert_create_exam_success"
    else
      flash[:danger] = t "alert_create_exam_fail"
    end
    redirect_to root_path
  end

  def index
    @exam = current_user.exams.new
    @subjects = Subject.all
    @exams = current_user.exams.desc.page(params[:page]).per Settings.exam_per_page
  end

  def show
    @exam.set_time_and_status if @exam.start?
    @exam.results.each do |result|
      result.build_result_answer
    end
  end

  def update
    if @exam.update_attributes update_exam_params
      if params[:commit] == "Save"
        flash[:success] = t "success_save_exam"
        redirect_to exam_path
      else
        @exam.set_uncheck_status
        flash[:success] = t "success_finish_exam"
        redirect_to root_path
      end
    else
      flash[:danger] = t "fail_finish_exam"
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:subject_id).merge! user: current_user
  end

  def update_exam_params
    params.require(:exam).permit results_attributes: [:id, :answer_id,
      results_answers_attributes: [:id, :answer_id,
        :answer_for_text, :_destroy]]
  end
end
