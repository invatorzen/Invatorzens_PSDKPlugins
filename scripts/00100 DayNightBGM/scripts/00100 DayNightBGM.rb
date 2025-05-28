#Adds _day and _night to the BGM name automatically based on the active switch
#By invatorzen
class Game_System
  attr_accessor :save_date

  # Plays a BGM
  # @param bgm [RPG::AudioFile] a descriptor of the BGM
  def bgm_play(bgm)
    @playing_bgm = bgm
    if bgm && !bgm.name.empty?

      #Tries to remove day/night if it already exists
      bgm.name.delete_suffix!("_day") if (bgm.name.end_with?("_day"))
      bgm.name.delete_suffix!("_night") if (bgm.name.end_with?("_night"))
      
      #Actually changes the bgm
      if ($game_switches[Yuki::Sw::TJN_MorningTime] || $game_switches[Yuki::Sw::TJN_DayTime]) #Day or Morning
        Audio.bgm_play(_utf8("Audio/BGM/" + bgm.name + "_day"), bgm.volume, bgm.pitch)
      elsif ($game_switches[Yuki::Sw::TJN_SunsetTime] || $game_switches[Yuki::Sw::TJN_NightTime]) #Sunset or Night
        Audio.bgm_play(_utf8("Audio/BGM/" + bgm.name + "_night"), bgm.volume, bgm.pitch)
      end
    else
      Audio.bgm_stop
    end
    Graphics.frame_reset
  end
end