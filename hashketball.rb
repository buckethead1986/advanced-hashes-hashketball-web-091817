require 'pry'
# Write your code here!
def game_hash
  {
    :home => {
      :team_name => "Brooklyn Nets", #is a separate line for each key, or one long list preferred for hash display?
      :colors => ["Black", "White"],
      :players => {
        "Alan Anderson" => {
          :number => 0,
          :shoe => 16,
          :points => 22,
          :rebounds => 12,
          :assists => 12,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 1
        },
        "Reggie Evans" => {
          :number => 30,
          :shoe => 14,
          :points => 12,
          :rebounds => 12,
          :assists => 12,
          :steals => 12,
          :blocks => 12,
          :slam_dunks => 7
        },
        "Brook Lopez" => {
          :number => 11,
          :shoe => 17,
          :points => 17,
          :rebounds => 19,
          :assists => 10,
          :steals => 3,
          :blocks => 1,
          :slam_dunks => 15 #damn.
        },
        "Mason Plumlee" => {
          :number => 1,
          :shoe => 19,
          :points => 26,
          :rebounds => 12,
          :assists => 6,
          :steals => 3,
          :blocks => 8,
          :slam_dunks => 5
        },
        "Jason Terry" => {
          :number => 31,
          :shoe => 15,
          :points => 19,
          :rebounds => 2,
          :assists => 2,
          :steals => 4,
          :blocks => 11,
          :slam_dunks => 1
        }
      }
    },
    :away => {
      :team_name => "Charlotte Hornets",
      :colors => ["Turquoise", "Purple"], #wow I can't spell turquoise. Whats the etymology?
      :players => {
        "Jeff Adrien" => {
          :number => 4,
          :shoe => 18,
          :points => 10,
          :rebounds => 1,
          :assists => 1,
          :steals => 2,
          :blocks => 7,
          :slam_dunks => 2
        },
        "Bismak Biyombo" => {
          :number => 0,
          :shoe => 16,
          :points => 12,
          :rebounds => 4,
          :assists => 7,
          :steals => 7,
          :blocks => 15,
          :slam_dunks => 10
        },
        "DeSagna Diop" => {
          :number => 2,
          :shoe => 14,
          :points => 24,
          :rebounds => 12,
          :assists => 12,
          :steals => 4,
          :blocks => 5,
          :slam_dunks => 5
        },
        "Ben Gordon" => {
          :number => 8,
          :shoe => 15,
          :points => 33,
          :rebounds => 3,
          :assists => 2,
          :steals => 1,
          :blocks => 1,
          :slam_dunks => 0
        },
        "Brendan Haywood" => {
          :number => 33,
          :shoe => 15,
          :points => 6,
          :rebounds => 12,
          :assists => 12,
          :steals => 22,
          :blocks => 5,
          :slam_dunks => 12
        }
      }
    }
  }
end

# def good_practices
#   game_hash.each do |location, team_data|
#     #are you ABSOLUTELY SURE what 'location' and 'team data' are? use binding.pry to find out!
#     binding.pry
#       team_data.each do |attribute, data|
#         #are you ABSOLUTELY SURE what 'attribute' and 'team data' are? use binding.pry to find out!
#         binding.pry
#
#         #what is 'data' at each loop through out .each block? when will the following line of code work and when will it break?
#         data.each do |data_item|
#             binding.pry
#       end
#     end
#   end
# end
#
# good_practices

def num_points_scored(name)
  output = 0
  game_hash.each {|location, team_data| #do I need to use multiple 'collect's as I navigate down a nested hash? If not, does it mater which level I use 'collect on?'
    team_data.each {|attribute, data|
      if attribute == :players
        data.each {|player_name, stat_list|
          if player_name == name
            stat_list.each {|stats, values|
              if stats == :points
                output = values
              end
            }
          end
        }
      end
    }
  }
  output
end

def shoe_size(name) #I just copy pasted the entire num_points_scored method, and changed :points to :shoe, which makes me want to make an 'iterate all players' method with 'name' and 'stat' parameters.
  output = 0
  game_hash.each {|location, team_data| #do I need to use multiple 'collect's as I navigate down a nested hash? If not, does it mater which level I use 'collect on?'
    team_data.each {|attribute, data| #the answer is YES. YES YOU DO. ALL COLLECT
      if attribute == :players
        data.each {|player_name, stat_list| #I learned that 'stat' is a special word in ruby :D
          if player_name == name
            stat_list.each {|stats, values|
              if stats == :shoe
                output = values
              end
            }
          end
        }
      end
    }
  }
  output
end

def team_colors(team_name) #is this too confusing for convention with :team_name ?
  game_hash.collect {|location, team_data|
    team_data.collect {|attribute, data|
      if data == team_name
        game_hash[location][:colors]
      end
    }
  }.flatten.compact
end

def team_names
  game_hash.collect {|location, team_data|
    team_data.collect {|attribute, data|
      if attribute == :team_name
        data
      end
    }
  }.flatten.compact
end

def player_numbers(team_name)
  game_hash.collect {|location, team_data|
    if team_data[:team_name] == team_name
      team_data.collect {|attribute, data|
        if attribute == :players
          data.collect {|player_names, stat_list|
            stat_list.collect {|stats, values|
              if stats == :number
                values
              end
            }
          }
        end
      }
    end
  }.flatten.compact
end

def player_stats(name)
  output = {}
  game_hash.each {|location, team_data|
    team_data.each {|attribute, data|
      if attribute == :players
        data.each {|player_name, stat_list|
          if player_name == name
            output = stat_list
          end
        }
      end
    }
  }
  output
end

def big_shoe_rebounds
  biggest_shoe = 0
  rebounds = 0
  game_hash.each {|location, team_data|
    team_data.each {|attribute, data|
      if attribute == :players
        data.each {|player_name, stat_list|
          if stat_list[:shoe] > biggest_shoe
            biggest_shoe = stat_list[:shoe] #probably superfluous, but a nice check.
            rebounds = stat_list[:rebounds]
          end
        }
      end
    }
  }
  rebounds
end
