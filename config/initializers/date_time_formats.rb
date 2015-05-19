Date::DATE_FORMATS[:default] = '%d/%m/%Y'

Date::DATE_FORMATS.merge!({:db => '%d/%m/%Y', :fr_format => '%d/%m/%Y'})

# if you want to change the format of Time display then add the line below
Time::DATE_FORMATS[:default]= '%H:%M'

# if you want to change the DB date format.
Time::DATE_FORMATS.merge!({:db => '%H:%M', :fr_format => '%H:%M'})