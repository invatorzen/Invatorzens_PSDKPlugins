module Battle
  class Logic
    class BattleInfo
      class << self
        # Creates battleinfo from rival objects
        def from_rival_settings(rival1, rival2 = nil, ally = nil)
          battle_info = BattleInfo.new
          battle_info.add_party(0, *battle_info.player_basic_info)
          add_rival(battle_info, 1, rival1)
          # Adds another rival
          log_debug("rival2: #{rival2}")
          add_rival(battle_info, 1, rival2) unless rival2.nil?
          # Adds an ally
          add_rival(battle_info, 1, ally) unless ally.nil?
          battle_info.vs_type = 2 if battle_info.parties.any? { |party| party.size == 2 }
          battle_info
        end

        def add_rival(battle_info, bank, rival)
          large_image = rival.artwork_full
          rival.artwork_small

          bag = PFM::Bag.new
          rival.bag_items.each { |bag_entry| bag.add_item(bag_entry[:dbSymbol], bag_entry[:amount]) }
          log_debug("rival: #{rival.name} team: #{rival.team}")

          battle_info.add_party(bank, rival.team, rival.name, rival.trainer_class, large_image, bag, nil, rival.ai_level, rival.victory_text,
                                rival.defeat_text)
          # Additional battle settings specific to the rival, if needed
          battle_info.base_moneys[bank] << rival.base_money if bank == 1
          battle_info.battle_id = rival.battle_id if rival.battle_id != 0
          change_battle_bgms_for_rival(battle_info, rival)
        end

        # Similar to change_battle_bgms, but edited for rivals
        def change_battle_bgms_for_rival(battle_info, rival)
          r_battle_bgm = rival.battle_bgm
          r_victory_bgm = rival.victory_bgm
          r_defeat_bgm = rival.defeat_bgm
          unless r_battle_bgm.empty? || battle_info.battle_bgm != battle_info.guess_battle_bgm
            battle_info.battle_bgm = "audio/bgm/#{r_battle_bgm}"
          end
          unless r_defeat_bgm.empty? || battle_info.defeat_bgm != battle_info.guess_defeat_bgm
            battle_info.defeat_bgm = "audio/bgm/#{r_defeat_bgm}"
          end
          battle_info.victory_bgm = "audio/bgm/#{r_victory_bgm}" unless r_victory_bgm.empty? || battle_info.victory_bgm
        end
      end
    end
  end
end
