# program objectives : see notes / make notes / delete notes / exit program
# newlines are added to improve readability in terminal

user_exit = false
user_notes = []

# this code will be utilised several times, so we can make a function / method for it
def list_user_notes(array)
  puts "\n"
  array.each_with_index do |iteration, index|
    puts "#{index + 1}: #{iteration}" # index + 1 is because otherwise we start at count 0
  end
end

puts "\nWelcome to My Notes. What would you like to do?"
while user_exit == false

  puts "\n(please choose from one of the following options):
  Enter 1 to view existing notes.
  Enter 2 to make a new note.
  Enter 3 to delete a note.
  Enter 4 to exit program\n\n"

  user_choice = gets.chomp.to_i

  if user_choice == 4
    user_exit = true # while loop no longer has condition to operate, so will finish

  elsif user_choice == 1

    if user_notes.empty?
      puts '*** there are currently no saved notes ***'
    else
      print "\n*** your current notes are: ***\n"
      list_user_notes(user_notes)
    end

  elsif user_choice == 2 # make a new note

    print "\nPlease enter new note: \n\n"
    user_notes.append(gets.chomp)

  elsif user_choice == 3 # delete a note

    if user_notes.empty?
      puts '*** there are currently no saved notes ***'
    else
      print "\n*** your current notes are: ***\n"
      list_user_notes(user_notes)
      puts "\nWhich note do you want to delete ? Please enter the number...\n\n"
      index_location = gets.chomp.to_i - 1
      user_notes.delete_at(index_location) # variable index_locator created for my readability
      print "\n*** updated notes are now: ***\n"
      list_user_notes(user_notes)
    end

  elsif user_choice > 4
    puts "\n******** If you want more options than 1 to 4, then you need the PAID version !! ********\n" # easter egg

  else
    puts "\n******** Please only enter a single number to choose from the options provided ********\n"

  end
end

puts "\nThank you for using My Notes\n\n"
