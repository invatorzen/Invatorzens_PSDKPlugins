module PFM
  # The InGame skill/move information of a Pokemon
  # @author Nuri Yuri
  class Skill
    # Return the text of the PP of the skill
    # @return [String]
    def pp_text
      type == data_type(:shadow).id ? "--/--" : "#{@pp} / #{@ppmax}"
    end
  end
end