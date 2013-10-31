module PagesHelper

  def next_page(user, page)
    current_page = page.sequence_id
    next_page =  page.subject.pages.find_by_sequence_id(current_page + 1)
    if next_page.nil?
      return user_subject_complete_path(user, page.subject)
    else
      page_to_pageable_path(user, next_page) 
    end
  end

  def progress(page)
    current_page = page.sequence_id.to_f
    total_pages = page.subject.pages.count.to_f
    progress = current_page / total_pages * 100
    return progress
  end


  def show_image(pageable)
    if pageable.image?
      image_tag(pageable.image_url(:thumb))
    else  
      "No image" 
    end
  end
end
