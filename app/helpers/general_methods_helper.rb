module GeneralMethodsHelper

  def require_logged_in_user
    unless user_signed_in?
      flash[:danger] = t "require_logged_in"
      redirect_to root_path
    end
  end

  def require_logged_in_as_admin
    unless current_user.admin?
      sign_out
      redirect_to root_path
    end
  end

  def load_exam
    @exam = Exam.find_by id: params[:id]
    if @exam.nil?
      flash[:danger] = t "Nil_exam"
      redirect_to root_url
    end
  end

  def disable_role_change user
    current_user.is? user
  end

end
