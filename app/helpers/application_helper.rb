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
    # only future
    unless (Date.today>date) or (Date.today==date and Time.now.hour>hour.to_i)
      reserve = Reserve.find_by_date DateTime.new(date.year, date.mon, date.day, hour.to_i)
      label, with_elem = label_with_elem(reserve)
      if with_elem
        id = "#{date.year}/#{date.mon}/#{date.day}/#{hour}"
        link_to label, "/reserves/book/#{id}", :remote => true, :id=>id.gsub('/','_')
      else
        label
      end
    end
  end

  def now
    # Show next week if weekend
    if Date.today.saturday? or Date.today.sunday? or (Date.today.friday? and Time.now.hour>23)
      (Date.today+3.day).beginning_of_week
    else
      Date.today.beginning_of_week
    end
    # Next Day
    #if Time.now.hour>23
    #  Date.current.next
    #else
    #  Date.current
    #end
  end

  def head_tag
    I18n.t('table_head')+I18n.t('date.util_day_names').values
=begin
    today = I18n.t('date.util_day_names').select{|k,i| k==now.wday}.values.join
    # Another way
    #seq = I18n.t('date.util_day_names').values.join(' ').split(today) unless today.empty?
    #seq.reverse.insert(1, today).join(' ').scan(/\w+/)
    rest_days = I18n.t('date.util_day_names').values[I18n.t('date.util_day_names').values.index(today)..-1]
    return (I18n.t('table_head') + rest_days + I18n.t('date.util_day_names').values).take(6)
=end    
  end

end
