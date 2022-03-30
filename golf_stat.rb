# Par count for comparitive values
par_count = { one: 4, two: 4, three: 5, four: 3, five: 4, six: 4, seven: 4, eight: 3, nine: 4,
              ten: 3, eleven: 4, twelve: 5, thirteen: 4, fourteen: 4, fifteen: 4, sixteen: 4, seventeen: 4, eighteen: 4 }
# High Scores for personal scores to merge the best in.
high_score = { one: nil, two: nil, three: nil, four: nil, five: nil, six: nil, seven: nil, eight: nil, nine: nil,
               ten: nil, eleven: nil, twelve: nil, thirteen: nil, fourteen: nil, fifteen: nil, sixteen: nil, seventeen: nil, eighteen: nil }
# Default scores
personal_score = high_score.clone

puts "Welcome to the golf stat tracker!"

# Add score method, this is what lets you input values into personal_score hash  # personal score is the sole parameter
def add_score(ps)
    puts "Which set of holes? (f)ront nine, (b)ack nine, or (a)ll eighteen"
    choice = gets.chomp.downcase # Getting input for menu option
    case choice # Case method based off 'choice' variable   ### TODO ONLY ADD NUMBERS
    when "f" # Front 9 holes
        puts "Enter stroke count: "
        ps.first(9).each do |k, _v|
            ps[k] = gets.chomp.to_i # Add to hash 1-9
        end
    when "b" # Back 9 holes
        puts "Enter stroke count: "
        ps.each_with_index do |k, i| # going through each with index, with a to_a method to make sure I can use array methods on the hash.
            if i < 9 # I don't want the front 9 holes to be changed
                next # if index is under 9 ie 'hole 10' then skip to next index
            else
                ps[k[0]] = gets.chomp.to_i # changing the value of k, which is :ten, :eleven and so on.
            end
        end
    when "a" # All 18 holes
        puts "Enter stroke count: "
        ps.each { |k, _v| ps[k] = gets.chomp.to_i } # Add to hash 1-18
    else
        puts "Not a valid input" if choice != "5"
    end
end

# Menu method, this is the main menu and how it navigates. # Parameters: par_count, personal_score and high_score
def menu(pc, ps, hs)
    while true # Loop which starts menu and only breaks in quit (5)
        puts "\nWhat would you like to do? (1.Add round, 2.View Course Par, 3.View past scores, 4.View high scores, 5.Quit)"
        input = gets.chomp # Haven't fixed this to accept no other values yet.
        case input
        when "1" # Add round
            add_score(ps) # Call to add_score Method
        when "2" # View Course Par
            pc.each { |hole, par| p "Hole #{hole.capitalize} is #{par} par" } # displays the courses par
        when "3" # View Past Scores
            if ps[:one].nil? && ps[:ten].nil? # if statement to check if any values exist yet
                puts "No Personal score yet." # Checks if hash is empty and delivers this outcome
            else
                # puts "You had a stroke count of #{ps.values.sum}"     ### TODO FIX ERROR CAN'T ADD NIL might have to make a incrementer thing
                puts "Scores: "
                # Goes through all available personal scores
                ps.each do |k, v|
                 p "Hole: #{k.capitalize} @ #{v}" unless v.nil?
                end
            end
        when "4" # Viewing the high scores      ### TODO NOT IMPLEMENTED
            puts "Best score!"
            hs.each { |k, v| p "Hole: #{k.capitalize} @ #{v}" unless v.nil? }
        when "5" # Quit
            puts "Goodbye"
            break
        end
    end
end

# Planning to merge ps into hs, and only take values that are higher.
def make_highest(ps, hs)
  # whatever the highest value of each hash is, take that and place it in hs
  # if ps[key] = value > hs[key] = value
  # save into hs{}
end

# Plan to make a method that works out an average of all your scores
def make_average(ps)
# This needs my read and write part to be active
end

# Planning to have a feature which saves hashes to a file to recall or use presonally. 
# also would use this in the make_average, make_highest methods
def save_to_file(ps, hs)
end


# Method call and parameters
menu(par_count, personal_score, high_score)
