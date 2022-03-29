mowbray_par = { one: 4, two: 4, three: 5, four: 3, five: 4, six: 4, seven: 4, eight: 3, nine: 4,
                ten: 3, eleven: 4, twelve: 5, thirteen: 4, fourteen: 4, fifteen: 4, sixteen: 4, seventeen: 4, eighteen: 4 }
mowbray_hs = { one: nil, two: nil, three: nil, four: nil, five: nil, six: nil, seven: nil, eight: nil, nine: nil,
                ten: nil, eleven: nil, twelve: nil, thirteen: nil, fourteen: nil, fifteen: nil, sixteen: nil, seventeen: nil, eighteen: nil }
mowbray_ps = mowbray_hs.clone

puts "Welcome to the golf stat tracker!"
while true
    puts "\nWhat would you like to do? (1.Add round, 2.View Course Par, 3.View past scores, 4.View high scores, 5.Quit)"
    input = gets.chomp
    case input
    when "1"
        # Add a score, choose the hole where the score is going
        puts "Which set of holes? (f)ront nine, (b)ack nine, or (a)ll eighteen"
        choice = gets.chomp.downcase
        case choice
        when "f"
            puts "Enter stroke count: "
            mowbray_ps[:one] < gets.chomp.to_i # Add to hash 1-9 # Try making an iterator method that goes through 1-9 and adds each
        when "b"
            puts "Enter stroke count: "
            gets.chomp.to_i # Add to hash from 10-18
        when "a"
            puts "Enter stroke count: "
            gets.chomp.to_i # Add to hash 1-18
        else
            puts "Not a valid input" if choice != "5" # Catching improper inputs, and also if 5(which is quit) sends user back to main menu
            next
        end
    when "2"
        mowbray_par.each_pair { |k, v| p "Hole #{k.capitalize} is #{v} par" } # displays the courses par
    when "3"
        if mowbray_ps.empty?
            puts "No Personal score yet." # Checks if hash is empty and delivers this outcome
            next
        else
            mowbray_par.each_pair { |k, v| p "Hole #{k.capitalize} is #{v} par" }
        end
    when "4"
        puts "This is where highscores go"
    when "5"
        puts "Goodbye"
        break
    end
end
