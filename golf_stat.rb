mowbray_par = { one: 4, two: 4, three: 5, four: 3, five: 4, six: 4, seven: 4, eight: 3, nine: 4,
                ten: 3, eleven: 4, twelve: 5, thirteen: 4, fourteen: 4, fifteen: 4, sixteen: 4, seventeen: 4, eighteen: 4 }
mowbray_hs = {}
mowbray_ps = {}

puts "Welcome to the golf stat tracker!"
while true
    puts "What would you like to do? (1.Add round, 2.View Course Par, 3.View past scores, 4.View high scores, 5.Quit)"
    input = gets.chomp
    case input
    when "1"
        # Add a score, choose the hole where the score is going
        puts "Which set of holes? (f)ront nine, (b)ack nine, or (a)ll eighteen"
        choice = gets.chomp.downcase
        case choice
        when "f"
            puts "Enter stroke count: "
            gets.chomp.to_i
        when "b"
            puts "Enter stroke count: "
            gets.chomp.to_i
        when "a"
            puts "Enter stroke count: "
            gets.chomp.to_i
        else
            puts "Not a valid input" if choice != "5"
            next
        end
    when "2"

    when "3"

    when "4"

    when "5"

    end
end
