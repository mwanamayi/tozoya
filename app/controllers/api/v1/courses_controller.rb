class Api::V1::CoursesController < ApplicationController
  skip_before_filter  :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  before_filter :authenticate_user!

  def index_specific
    @registered_courses = current_user.courses
    @school = current_user.school
  end

  def students
    p "params are #{params}"
    @course = Course.find(params[:id])
    p "course is #{@course}"
    @students = @course.students

  end

end
