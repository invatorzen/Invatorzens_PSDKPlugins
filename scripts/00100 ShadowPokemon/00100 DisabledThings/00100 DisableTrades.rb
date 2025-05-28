# Disables GTS trades
module GTS
  class Scene < SearchMethod
    private
    # Perform the action related to the Pokemon on the GTS
    def do_command1
      if @uploaded
        summary
        refresh_sprites
      else
        return false unless (choice = choose_pokemon)

        party = choice >= 31
        pkmn = party ? $actors[choice - 31] : $storage.info(choice - 1)
        if party && PFM.game_state.pokemon_alive == 1 && !pkmn.dead?
          display_message(ext_text(8997, 35))
          return
        end
        if pkmn.absofusionned?
          display_message(parse_text(33, 118))
          return
        end
        if pkmn.shadow?
          display_message(parse_text(33, 118))
          return
        end
        data = nil
        call_scene(WantedDataScene) { |scene| data = scene.wanted_data }
        pkmn.form_calibrate(:none) if %i[shaymin tornadus thundurus landorus].include?(pkmn.db_symbol)
        if data.is_a?(Array) && Core.upload_pokemon(pkmn, data)
          PFM.game_state.online_pokemon = pkmn.clone
          party ? PFM.game_state.remove_pokemon(choice - 31) : $storage.remove(choice - 1)
          GamePlay::Save.save
          refresh_sprites
        end
      end
    end
  end
end


# Disabled NPC trades
class Interpreter
  # Sequence that perform NPC trade
  # @param index [Integer] index of the Pokemon in the party
  # @param pokemon [PFM::Pokemon] Pokemon that is traded with
  alias old_npc_trade npc_trade_sequence
  def npc_trade_sequence(index, pokemon)
    return unless $actors[index].is_a?(PFM::Pokemon)
    actor = $actors[index]
    message(parse_text(33, 118)) if actor.shadow?
    return if actor.shadow?
    old_npc_trade(index, pokemon)
  end
end