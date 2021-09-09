# program objectives : see notes / make notes / delete notes / exit program
# additional objectives : modify notes / add dates / add categories / save notes
# newlines are added to improve readability in terminal

user_exit = false
user_entries = []

if File.exist?("saved_user_notes.txt")
  
  file_handle = File.read("saved_user_notes.txt")
  # closing a file in read mode is LESS of an issue than one in open mode, although
  # I will need to work on the syntax for closing files.... 
  count = 1
  iterated_category = ""
  iterated_date = ""
  iterated_note = ""

  file_handle.each_line do |iteration|
    if count == 1
      iterated_category = iteration.chomp
      count += 1

    elsif count == 2
      iterated_date = iteration.chomp
      count += 1

    else
      iterated_note = iteration.chomp
      user_entries.append(
        {
          category: iterated_category,
          date: iterated_date,
          note: iterated_note
        }
      )
      count = 1
    end
  end 
  # file_handle.close()  # will need to learn this properly, as not functioning
end

# this code will be utilised several times, so we can make a function / method for it
def list_user_entries(array)
  puts "\n"
  array.each_with_index do |iteration, index|
    puts "#{index + 1}: #{iteration[:date]}: #{iteration[:category].rjust(13)} || #{iteration[:note].ljust(15)} " # index + 1 is because otherwise we start at count 0
  end
end

puts "\nWelcome to My Notes. What would you like to do?"
while user_exit == false

  puts "\n(please choose from one of the following options):
  Enter 1 to view existing notes.
  Enter 2 to make a new note.
  Enter 3 to modify an existing note
  Enter 4 to delete a note.
  Enter 5 to exit program\n\n"

  user_choice = gets.chomp.to_i

  case user_choice

  when 5 # exit program with option to save
    user_exit = true # "while loop" no longer has condition to operate, so will finish
    puts "\nWould you like to save changes ? 
    Select Y to save notes, otherwise choose any other key for changes to be discarded !!\n\n"
    save_changes = gets.chomp
    case save_changes
      when "Y"
        File.write("saved_user_notes.txt", nil, mode: "w")
        # the above clears the file, which is needed as only appending a triplet of values each time
        # and if below was in write-mode instead then it would overwrite each triplet of values
        user_entries.each do |iteration|
          x = iteration[:category]
          y = iteration[:date]
          z = iteration[:note]
          File.write("saved_user_notes.txt", x + "\n" + y + "\n" + z + "\n", mode: "a")
        end
        # File.close # I think the above self closes ?
        puts "\nChanges Saved\n"
      else
        puts "\nChanges NOT saved. Changes Discarded\n"
    end


  when 1 # add a new note

    if user_entries.empty?
      puts '*** there are currently no saved notes to view ***'
    else
      print "\n*** your current notes are: ***\n"
      list_user_entries(user_entries)
    end

  when 2 # make a new note

    puts "\nPlease choose which category this note belongs to :
    1. URGENT
    2. Work
    3. Personal
    4. Other\n"
    user_category_choice = gets.chomp.to_i
    note_category = "None Selected"
    case user_category_choice
      when 1
        note_category = "URGENT"
      when 2
        note_category = "Work"
      when 3
        note_category = "Personal"
      when 4
        note_category = "Other"
      end
    print "\nPlease enter new note: \n\n"

    current_date = Time.now.to_s
    user_entries.append(
      {
        category: note_category,
        date: current_date[0..9],
        note: gets.chomp
      }
    )

  when 3 # modify a note

    if user_entries.empty?
      puts '*** there are currently no saved notes to modify ***'
    else
      puts "\nCAUTION: THIS WILL OVERWRITE YOUR ORIGINAL NOTE !!\n\nWrite Y to proceed or choose any other key to return to main menu\n\n"
      escape_clause = gets.chomp
      case escape_clause
      when 'Y'
        print "\n*** your current notes are: ***\n"
        list_user_entries(user_entries)

        puts "\nWhich note do you want to modify ? Please enter the number...\n\n"
        index_location = gets.chomp.to_i - 1

        note_category = "N/A"

        puts "\nPlease choose which category this note belongs to :
        1. URGENT
        2. Work
        3. Personal
        4. Other\n"
        user_category_choice = gets.chomp.to_i
        note_category = "None Selected"
        case user_category_choice
          when 1
            note_category = "URGENT"
          when 2
            note_category = "Work"
          when 3
            note_category = "Personal"
          when 4
            note_category = "Other"
          end
          
        puts "\nPlease write your new note.\n\n"
        current_date = Time.now.to_s
        user_entries[index_location][:category] = note_category
        user_entries[index_location][:date] = current_date[0..9]
        user_entries[index_location][:note] = gets.chomp

      end
    end

  when 4 # delete a note

    if user_entries.empty?
      puts '*** there are currently no saved notes to delete ***'
    else
      puts "\nCAUTION: THIS WILL DELETE YOUR ORIGINAL NOTE !!\n\nWrite Y to proceed or choose any other keyto return to main menu\n\n"
      escape_clause = gets.chomp
      case escape_clause
      when 'Y'
        print "\n*** your current notes are: ***\n"
        list_user_entries(user_entries)
        puts "\nWhich note do you want to delete ? Please enter the number...\n\n"
        index_location = gets.chomp.to_i - 1
        user_entries.delete_at(index_location) # variable index_locator created for my readability
        print "\n*** updated notes are now: ***\n"
        list_user_entries(user_entries)
      end
    end

  when 6
    puts "\n******** If you want access to option 6, then you need the PAID version !! ********\n" # easter egg

  when 7
    puts "\n******** You're not ready for option 7 ********\n" # easter egg

  else
    puts "\n******** Please only enter a single number to choose from the options provided ********\n"

  end
end

puts "\nThank you for using My Notes\n\n"
