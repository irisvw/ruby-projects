require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

# ASSIGNMENT: Clean phone numbers
def clean_phonenumber(number)
  if number.length == 10
    number
  elsif number.length == 11
    number.first == 1 ? number[1..10] : false
  else
    false
  end
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter
time_array = []
day_array = []

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  regdate = row[:regdate]
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  # ASSIGNMENT: Time targeting
  time = Time.strptime(regdate, '%m/%d/%Y %H:%M')
  time_array << time.strftime("%H")

  # ASSIGNMENT: Day of the week targeting
  day_array << Date::ABBR_DAYNAMES[time.wday]
end

# Display sorted arrays
puts "Best hours: #{time_array.tally.sort_by { |_key, value| -value }}"
puts "Best days: #{day_array.tally.sort_by { |_key, value| -value }}"
