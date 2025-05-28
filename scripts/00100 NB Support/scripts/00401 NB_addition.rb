# Modifies how the genderizer works, allowing more options than male or female since it uses a variable now.
# Credits: Invatorzen
module PFM
  module Text
    module_function
    def parse_string_for_messages(text)
      return text.dup if text.empty? # or text.frozen?

      # Detect dialog
      text = detect_dialog(text).dup
      # Gsub text
      text.gsub!(/\\\\/, S_000)
      text.gsub!(/\\v\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
      text.gsub!(/\\n\[([0-9]+)\]/i) { $game_actors[$1.to_i]&.name }
      text.gsub!(/\\p\[([0-9]+)\]/i) { $actors[$1.to_i - 1]&.name }
      text.gsub!(/\\k\[([^\]]+)\]/i) { get_key_name($1) }
      text.gsub!('\E') { $game_switches[Yuki::Sw::Gender] ? 'e' : nil }
      text.gsub!(/\\f\[([^\]]+)\]/i) { $1.split('§')[$game_variables[Yuki::Var::GenderVar]] }
      text.gsub!(/\\t\[([0-9]+), *([0-9]+)\]/i) { ::PFM::Text.parse($1.to_i, $2.to_i) }
      # text.gsub!(NBSP_B, NBSP_R)
      text.gsub!(*Dot)
      text.gsub!(*Money)
      @variables.each { |expr, value| text.gsub!(expr, value) }
      text.gsub!(KAPHOTICS_Clean, S_Empty)
      return text
    end
  end
end