require 'open-uri'

def get_visited_link_list
  visited = []

  if File.exist? "visited"
    File.open("visited", "r").each_line do |link|
      visited  << link
    end
  end

  return visited
end

def add_visited_link(link)
  File.open("visited", 'a') {|file| file.puts("#{link}")}
end

def get_email_list
  emails = []

  if File.exist? "email_list"
    File.open("email_list").each_line do |email|
      email["\n"] = ''
      emails << email
    end
  end
  return emails
end

def add_email_to_list(email)
  File.open("email_list", 'a') {|file| file.puts("#{email}")}
end

count = 1
beginning_time = Time.now

File.open("link_list", "r").each_line do |link|
  puts "count:#{count}"
  visited_link_list = get_visited_link_list
  if visited_link_list.include? link
    puts "visited:#{link}"
  else

    puts "new link:#{link}"

    file = open(link)
    contents = file.read
    #puts contents

    contents.scan(/[a-zA-Z0-9\.]+@[a-zA-Z0-9\.]+/) {|email| 
    email_list = get_email_list  

      if email_list.include? email
        puts "email exist:#{email}"
      else 
        puts "new email:#{email}\n"
        add_email_to_list(email)
      end
    }

    add_visited_link(link)

    sleep(1)
  end

  end_time = Time.now
  puts "Time elapsed #{(end_time - beginning_time)} seconds"
  count += 1
end