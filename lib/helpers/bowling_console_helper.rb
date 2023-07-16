class BowlingConsoleHelper
  def self.print_score_table(players)
    header = "Frame\t\t"
    10.times { |i| header += "#{i+1}\t\t" }

    puts header
    players.each do |_, player|
      puts player.name
      pinfalls_row = "Pinfalls\t"
      player.pinfalls.each do |rolls|
        rolls.each do |roll|
          pinfalls_row += roll
          pinfalls_row += "\t"
          pinfalls_row += "\t" if rolls.length == 1
        end
      end
      puts pinfalls_row

      score_row = "Score\t\t"
      player.score_list.each do |score|
        score_row += "#{score}\t\t"
      end
      puts score_row
    end
  end
end
