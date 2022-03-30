par_count = { one: 4, two: 4, three: 5, four: 3, five: 4, six: 4, seven: 4, eight: 3, nine: 4,
              ten: 3, eleven: 4, twelve: 5, thirteen: 4, fourteen: 4, fifteen: 4, sixteen: 4, seventeen: 4, eighteen: 4 }
high_score = { one: nil, two: nil, three: nil, four: nil, five: nil, six: nil, seven: nil, eight: nil, nine: nil,
               ten: nil, eleven: nil, twelve: nil, thirteen: nil, fourteen: nil, fifteen: nil, sixteen: nil, seventeen: nil, eighteen: nil }
personal_score = { one: nil, two: nil, three: nil, four: nil, five: nil, six: nil, seven: nil, eight: nil, nine: nil,
                   ten: nil, eleven: nil, twelve: nil, thirteen: nil, fourteen: nil, fifteen: nil, sixteen: nil, seventeen: nil, eighteen: nil }

puts "Welcome to the golf stat tracker!"

def add_score(ps)
    # Add a score, choose the hole where the score is going
    puts "Which set of holes? (f)ront nine, (b)ack nine, or (a)ll eighteen"
    choice = gets.chomp.downcase
    case choice
    when "f"
        puts "Enter stroke count: "
        ps.first(9).each do |k, _v| 
            ps[k] = gets.chomp.to_i # Add to hash 1-9
        end
    when "b"
        puts "Enter stroke count: "
        # Add to hash from 10-18
        ps.to_a.each_with_index do |k, i|
            if i < 9
                next
            else
                ps[k[0]] = gets.chomp.to_i
                p k
            end
        end
        p ps
    when "a"
        puts "Enter stroke count: "
        ps.each { |k, _v| ps[k] = gets.chomp.to_i } # Add to hash 1-18
    else
        puts "Not a valid input" if choice != "5"
    end
end

def menu(pc, ps, hs)
    while true
        puts "\nWhat would you like to do? (1.Add round, 2.View Course Par, 3.View past scores, 4.View high scores, 5.Quit)"
        input = gets.chomp
        case input
        when "1"
            add_score(ps)
        when "2"
            pc.each { |hole, par| p "Hole #{hole.capitalize} is #{par} par" } # displays the courses par
        when "3"
            if ps[:one].nil? && ps[:ten].nil?
                puts "No Personal score yet." # Checks if hash is empty and delivers this outcome
                next
            else
                # puts "You had a stroke count of #{ps.values.sum}" # TODO FIX ERROR CAN'T ADD NIL
                puts "Scores: "
                ps.each { |k, v| p "Hole: #{k.capitalize} @ #{v}" unless v.nil? }
            end
        when "4"
            puts "Best score!" # Prints best score # TODO implement System to take highest values
            hs.each { |k, v| p "Hole: #{k.capitalize} @ #{v}" unless v.nil? }
        when "5"
            puts "Goodbye"
            break
        end
    end
end

def make_highest(ps, hs)
  # whatever the highest value of each hash is, take that and place it in hs
  # if ps[key] = value > hs[key] = value
  # save into hs{}
end

menu(par_count, personal_score, high_score)
