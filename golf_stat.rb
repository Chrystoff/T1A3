# Par count of course
par_count = { one: 4, two: 4, three: 5, four: 3, five: 4, six: 4, seven: 4, eight: 3, nine: 4,
              ten: 3, eleven: 4, twelve: 5, thirteen: 4, fourteen: 4, fifteen: 4, sixteen: 4, seventeen: 4, eighteen: 4 }
# High Scores
high_score = { one: nil, two: nil, three: nil, four: nil, five: nil, six: nil, seven: nil, eight: nil, nine: nil,
               ten: nil, eleven: nil, twelve: nil, thirteen: nil, fourteen: nil, fifteen: nil, sixteen: nil, seventeen: nil, eighteen: nil }
# Default scores. Cloning high_score
personal_score = high_score.clone

# Error type for when nil values in records. used on line No. 105, 109
class NoRecordsError < ArgumentError
  def message
    system "clear"
    puts "No input Records yet.\n\n"
  end
end

# Error type for when someone enters empty values for their name. used on line No. 140, 144, 145
class InvalidNameError < StandardError
  def message
    system "clear"
    puts "Can't be empty!\n\n"
  end
end

# the class declaration of my app
class GolfApp
  system "clear"
  puts "Welcome to the golf stat tracker!"
  puts "The App that keeps track of your scores!"

  # Add score method, this is what lets you input values into personal_score hash  # personal score is the sole parameter
  def add_score(ps)
    puts "Which set of holes? (f)ront nine, (b)ack nine, or (a)ll eighteen"
    choice = gets.chomp.downcase # Getting input for menu option, downcasing for case comparisons
    case choice # Case method based off local 'choice' variable
    when "f" # ------------------------------Front 9 holes ---------------------------------------
      begin
        puts "Enter stroke count per hole: "
        ps.first(9).each do |k, _v|
        ps[k] = Integer(gets.chomp) # Add to hash 1-9
        rescue ArgumentError # Rescue for when value entered isn't integer
        p "Invalid entry. You can only enter integers" # Stops and rescues invalid inputs
        retry # re-attempt inputting value
        end
      end
      system "clear" # Clearing the terminal!
      puts "Added to score card" # Just so there's something to let you know something happened!
    when "b" # --------------------------------------Back 9 holes--------------------------------------
      begin
        puts "Enter stroke count per hole: "
        ps.each_with_index do |k, i| # going through each with index so I can get to the last 9 holes
          if i > 8 # If index is greater than 8 (holes 10+)
          ps[k[0]] = Integer(gets.chomp) # Adding to hash
          end
        rescue ArgumentError
          p "Invalid entry. You can only enter integers" # Stops and rescues invalid inputs
          retry
        end
      end
      system "clear"
      puts "Added to score card"
    when "a" # --------------------------------------All 18 holes--------------------------------------
      begin
        puts "Enter stroke count per hole: "
        ps.each { |k, _v| ps[k] = Integer(gets.chomp) } # Add to hash 1-18
      rescue ArgumentError
          p "Invalid entry. You can only enter integers" # Stops and rescues invalid inputs
          retry
      end
      system "clear"
      puts "Added to score card"
    when "6" # ----------------------- Quit App ------------------------------
      system "clear"
      puts "Back to Main Menu"
    else # Prompts the user what the quit button is, then calls this method again to re-do method
      system "clear"
      puts "Not a valid input, enter 6 to quit to main\n\n"
      add_score(ps) # Method call, otherwise it'd go back to the main menu just for a bad input
    end
  end

  # View past scores method
  def past_scores(past_s)
    if past_s[:one].nil? && past_s[:ten].nil? # Checks if hash is empty and delivers this outcome
      puts "No Personal score yet."
    else # If there have been any scores recorded, it'll display them here. Stroke count sum & stroke count per hole
      puts "Stroke count: #{past_s.compact.values.sum}"
      puts "Stroke count per hole: "
      # Goes through all available personal scores
      past_s.each do |hole, stroke|
        p "#{hole.capitalize} | #{stroke}" unless stroke.nil?
      end
    end
  end

  # Menu method, this is the main menu and how it navigates. # Parameters: par_count, personal_score and high_score
  def menu(pc, ps, hs)
    while true # Loop which starts menu and only breaks in quit (6)
      puts "\nWhat would you like to do?"
      puts "1.Add round, 2.View Course Par, 3.View past scores, 4.View high scores, 5.Save high score, 6. Quit"
      make_highest(ps, hs) # Calls the make highest method to make sure high score is always the highest score
      input = gets.chomp
      case input
      when "1" # -------------------------- Add round --------------------------
          system "clear"
          add_score(ps) # Call to add_score Method
      when "2" # --------------------------View Course Par--------------------------
          system "clear"
          pc.each { |hole, par| p "#{hole.capitalize} | #{par} par" }
      when "3" # --------------------------View Past Scores--------------------------
          system "clear"
          past_scores(ps)
      when "4" # --------------------------Viewing the high scores--------------------------
        system "clear"
        begin
          raise(NoRecordsError) if ps[:one].nil? && ps[:ten].nil? # if no scores are in the system this throws an error

          puts "Best score!" # if there is a score, then it continues on to this!
          puts "Stroke count: #{ps.compact.values.sum}" # gets the sum of all strokes played. compact loses all nil values
          hs.each { |k, v| p "#{k.capitalize} | #{v}" unless v.nil? }
        rescue NoRecordsError => e
          e.message # system "clear" && puts "No input Records yet.\n\n"
          next # Goes into next loop cycle
        end
      when "5" # --------------------------Saving high_score to a file--------------------------
        system "clear"
        begin
          raise(NoRecordsError) if ps[:one].nil? && ps[:ten].nil? # if no scores are in the system this throws an error

          save_to_file(hs) # Saves the high_score to records.txt
          p "Save complete" # Just so you know something happened!
        rescue NoRecordsError => e
          e.message # system "clear" && puts "No input Records yet.\n\n"
          next # Goes into next loop cycle
        end
      when "6" # -------------------------- Quit --------------------------
        system "clear"
        puts "Goodbye"
        break
      end
    end
  end

  # Gives High_score value of personal score only take values that are higher.
  def make_highest(ps, hs)
    ps.each do |k, v| # Go through all keys and values
      if hs[k].nil?       # If nil?
          hs[k] = v       # Replace it with personal_score v value
      elsif hs[k] > v     # If hs value is larger than ps value ### this was required. Rubocop hates it. But it was necessary because > doesn't compare to nil values
          hs[k] = v       # Replace it with personal_score v value
      end
    end
  end

  # Save the current highscore to a file
  def save_to_file(hs)
    begin
      time = Time.new
      p "Enter your name: "
      name = gets.chomp.capitalize
      raise(InvalidNameError) if name.empty? # Throws error if no name was entered

      p "Enter Course: "
      course = gets.chomp.capitalize
      raise(InvalidNameError) if course.empty? # Throws error if no course was entered
    rescue InvalidNameError => e
      e.message
      retry
    end
    file = File.open('records.txt', 'a') # Opens File for use. appending.
    file << "\n------------------#{course}----------------------"
    file << "\nScored on: #{time.day}/#{time.month}/#{time.year} by #{name}" # Adds a timestamp and your name next to it
    file << "\n------------------#{course}----------------------"
    file << "\nTotal Strikes: #{hs.compact.values.sum}" # Adds total strokes
    # Goes through highscore strokes per hole and prints them
    hs.each do |hole, hits|
     file << "\n#{hole.capitalize} | #{hits}" unless hits.nil?
    end
    file.close # Closes file. otherwise it won't save till program ends. or ever.
  end
end

golf = GolfApp.new # creates new instance of class GolfApp
golf.menu(par_count, personal_score, high_score) # Runs the file with the top of page hashes
