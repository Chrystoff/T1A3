# Par count for comparitive values
par_count = { one: 4, two: 4, three: 5, four: 3, five: 4, six: 4, seven: 4, eight: 3, nine: 4,
              ten: 3, eleven: 4, twelve: 5, thirteen: 4, fourteen: 4, fifteen: 4, sixteen: 4, seventeen: 4, eighteen: 4 }
# High Scores for personal scores to merge the best in.
high_score = { one: nil, two: nil, three: nil, four: nil, five: nil, six: nil, seven: nil, eight: nil, nine: nil,
               ten: nil, eleven: nil, twelve: nil, thirteen: nil, fourteen: nil, fifteen: nil, sixteen: nil, seventeen: nil, eighteen: nil }
# Default scores
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

class GolfApp
    system "clear"
    puts "Welcome to the golf stat tracker!"
    puts "The App that keeps track of your scores!"

    # Add score method, this is what lets you input values into personal_score hash  # personal score is the sole parameter
    def add_score(ps)
        puts "Which set of holes? (f)ront nine, (b)ack nine, or (a)ll eighteen"
        choice = gets.chomp.downcase # Getting input for menu option
        case choice # Case method based off 'choice' variable   ### TODO ONLY ADD NUMBERS
        when "f" # Front 9 holes
            begin
                puts "Enter stroke count per hole: "
                ps.first(9).each do |k, _v|
                ps[k] = Integer(gets.chomp) # Add to hash 1-9
                rescue ArgumentError # Rescue for when value entered isn't number
                    p "Invalid entry. You can only enter integers" # Stops and rescues invalid inputs
                    retry
                end
            end
            system "clear"
            puts "Added to score card"
        when "b" # Back 9 holes
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
        when "a" # All 18 holes
            begin
                puts "Enter stroke count per hole: "
                ps.each { |k, _v| ps[k] = Integer(gets.chomp) } # Add to hash 1-18
            rescue ArgumentError
                p "Invalid entry. You can only enter integers" # Stops and rescues invalid inputs
                retry
            end
            system "clear"
            puts "Added to score card"
        when "6" # Quit App
            system "clear"
            puts "Back to Main Menu"
        else # Prompts the user what the quit button is, then calls this method again to re-do method
            system "clear"
            puts "Not a valid input, enter 6 to quit to main\n\n"
            add_score(ps)
        end
    end

    # View past scores method
    def past_scores(past_s)
        if past_s[:one].nil? && past_s[:ten].nil? # Checks if hash is empty and delivers this outcome
            puts "No Personal score yet."
        elsif !past_s[:one].nil? && !past_s[:ten].nil? # Checks if hash is full and delivers stroke count
            puts "You had a stroke count of #{past_s.values.sum} for all eighteen Holes"
            puts "Here are the scores per hole: "
            past_s.each do |hole, stroke|
                p "#{hole.capitalize} | #{stroke}" unless stroke.nil?
            end
        else
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
        while true # Loop which starts menu and only breaks in quit (5)
            puts "\nWhat would you like to do?"
            puts "1.Add round, 2.View Course Par, 3.View past scores, 4.View high scores, 5.Save high score, 6. Quit"
            make_highest(ps, hs)
            input = gets.chomp # Haven't fixed this to accept no other values yet.
            case input
            when "1" # Add round
                system "clear"
                add_score(ps) # Call to add_score Method
            when "2" # View Course Par
                system "clear"
                pc.each { |hole, par| p "#{hole.capitalize} | #{par} par" } # displays the courses par
            when "3" # View Past Scores
                system "clear"
                past_scores(ps)
            when "4" # Viewing the high scores
                system "clear"
                begin
                    raise(NoRecordsError) if ps[:one].nil? && ps[:ten].nil?

                    puts "Best score!"
                    puts "Stroke count: #{ps.compact.values.sum}"
                    hs.each { |k, v| p "#{k.capitalize} | #{v}" unless v.nil? }
                rescue NoRecordsError => e
                    e.message
                    next
                end
            when "5" # Saving high_score to a file
                system "clear"
                begin
                    raise(NoRecordsError) if ps[:one].nil? && ps[:ten].nil?

                    save_to_file(hs)
                    p "Save complete"
                rescue NoRecordsError => e
                    e.message
                    next
                end
            when "6" # Quit
                system "clear"
                puts "Goodbye"
                break
            end
        end
    end

    # Gives High_score value of personal score only take values that are higher.
    def make_highest(ps, hs)
        ps.each do |k, v| # Go through all keys
            hs[k] = v if hs[k].nil? || hs[k] != k # if hash value is nil OR hash value is not equal to personal score
        end
    end

    # Save the current highscore to a file
    def save_to_file(hs)
        begin
            time = Time.new
            p "Enter your name: "
            name = gets.chomp.capitalize
            raise(InvalidNameError) if name.empty?

            p "Enter Course: "
            course = gets.chomp.capitalize
            raise(InvalidNameError) if course.empty?
        rescue InvalidNameError => e
            e.message
            retry
        end
        file = File.open('records.txt', 'a')
        file << "\n------------------#{course}----------------------"
        file << "\nScored on: #{time.day}/#{time.month}/#{time.year} by #{name}"
        file << "\n------------------#{course}----------------------"
        file << "\nTotal Strikes: #{hs.compact.values.sum}"
        hs.each { |hole, hits| file << "\n#{hole.capitalize} | #{hits}" unless hits.nil? }
        file.close
    end
end

golf = GolfApp.new
golf.menu(par_count, personal_score, high_score)
