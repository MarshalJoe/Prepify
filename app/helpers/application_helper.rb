module ApplicationHelper

  
  def page_to_pageable_path(user, page) 
    if page.pageable_type == "Question"    
      return user_subject_question_path(user.id, page.subject_id, page.pageable.id)
    elsif page.pageable_type == "Instruction"
      return user_subject_instruction_path(user.id, page.subject_id, page.pageable.id)
    else
      return user_subjects_path
    end
  end

  # How do I grab the user id?

  def new_course(user,page)
  new_course = CourseProgression.create(user_id: user.id, subject_id: page.subject_id , page_id: page.id)
  end

  def update_course(user, page)
    course = CourseProgression.find_by(user_id: user.id, subject_id: page.subject_id)
    if course.nil?
      new_course(user,page)
      page_to_pageable_path(user,page)
    elsif course.page_id == (page.id - 1) 
      course.update(page_id: page.id)
      page_to_pageable_path(user,page)
    else
    course.completed_at = DateTime.new
    page_to_pageable_path(user, page)
    end
  end
end



