module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def label_with_elem(reserve)
    if reserve.nil?
      ['Reserve', true]
    elsif reserve.user_id==current_user.id
      ['Uncheck', true]
    else # There is and aren't you
      ["reserved for #{reserve.user.email}", false]
    end    
  end

  def reserve_tag(date, hour)
    reserve = Reserve.find_by_date DateTime.new(date.year, date.mon, date.day, hour.to_i)
    label, with_elem = label_with_elem(reserve)
    # only future
    unless (Date.today>date) or (Date.today==date and Time.now.hour>hour.to_i)
      if with_elem
        id = "#{date.year}/#{date.mon}/#{date.day}/#{hour}"
        link_to label, "/reserves/book/#{id}", :remote => true, :id=>id.gsub('/','_')
      else
        label
      end
    else # past
      "reserved for #{reserve.user.email}"
    end
  end

  def now(date=Date.today)
    # Show next week if weekend
    if date.saturday? or date.sunday?
      (date+3.day).beginning_of_week
    else
      date.beginning_of_week
    end
  end

  def head_tag
    I18n.t('table_head')+I18n.t('date.util_day_names').values
  end

end
