module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, { :sort => column, :direction => direction }, { :class => css_class }
  end

  def label_with_elem(reserve)
    if reserve.nil?
      [btn_reserve, true]
    elsif reserve.user_id==current_user.id
      [btn_uncheck, true]
    else # There is and aren't you
      [btn_reserved( reserve.user.email), false]
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
      btn_reserved( reserve.user.email) if reserve
      #"reserved for #{reserve.user.email}"
    end
  end
  
  def btn_uncheck
    "<span class='btn-lg glyphicon glyphicon-remove-circle'></span>You".html_safe
  end
  def btn_reserve
    "<span class='btn glyphicon glyphicon-plus-sign'></span>".html_safe
  end
  def btn_reserved(txt='')
    %{
      <span class='btn-lg glyphicon glyphicon-ok-sign'></span>#{txt}
    }.html_safe
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
