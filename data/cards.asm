MAX_CARD_TEXT_LENGTH		equ	#3E + #01
TOKEN_NUM		equ	#34
END_CARD_TEXT		equ	'@'
TOKEN_ID		equ	#80
map_jump_data:	; size: 204 bytes
	dw 	jump_brick_shortage:
	dw 	jump_lucky_cache:
	dw 	jump_friendly_terrain:
	dw 	jump_miners:
	dw 	jump_mother_lode:
	dw 	jump_dwarven_miners:
	dw 	jump_work_overtime:
	dw 	jump_copping_the_tech:
	dw 	jump_basic_wall:
	dw 	jump_sturdy_wall:
	dw 	jump_innovations:
	dw 	jump_foundations:
	dw 	jump_tremors:
	dw 	jump_secret_room:
	dw 	jump_earthquake:
	dw 	jump_big_wall:
	dw 	jump_collapse_:
	dw 	jump_new_equipment:
	dw 	jump_strip_mine:
	dw 	jump_reinforced_wall:
	dw 	jump_porticulus:
	dw 	jump_crystal_rocks:
	dw 	jump_harmonic_ore:
	dw 	jump_mondo_wall:
	dw 	jump_focused_designs:
	dw 	jump_great_wall:
	dw 	jump_rock_launcher:
	dw 	jump_dragon_s_heart:
	dw 	jump_forced_labor:
	dw 	jump_rock_garden:
	dw 	jump_flood_water:
	dw 	jump_barracks:
	dw 	jump_battlements:
	dw 	jump_shift:
	dw 	jump_quartz:
	dw 	jump_smoky_quartz:
	dw 	jump_amethyst:
	dw 	jump_spell_weavers:
	dw 	jump_prism:
	dw 	jump_lodestone:
	dw 	jump_solar_flare:
	dw 	jump_crystal_matrix:
	dw 	jump_gemstone_flaw:
	dw 	jump_ruby:
	dw 	jump_gem_spear:
	dw 	jump_power_burn:
	dw 	jump_harmonic_vibe:
	dw 	jump_parity:
	dw 	jump_emerald:
	dw 	jump_pearl_of_wisdom:
	dw 	jump_shatterer:
	dw 	jump_crumblestone:
	dw 	jump_sapphire:
	dw 	jump_discord:
	dw 	jump_fire_ruby:
	dw 	jump_quarry_s_help:
	dw 	jump_crystal_shield:
	dw 	jump_empathy_gem:
	dw 	jump_diamond:
	dw 	jump_sanctuary:
	dw 	jump_lava_jewel:
	dw 	jump_dragon_s_eye:
	dw 	jump_crystallize:
	dw 	jump_bag_of_baubles:
	dw 	jump_rainbow:
	dw 	jump_apprentice:
	dw 	jump_lightning_shard:
	dw 	jump_phase_jewel:
	dw 	jump_mad_cow_disease:
	dw 	jump_faerie:
	dw 	jump_moody_goblins:
	dw 	jump_minotaur:
	dw 	jump_elven_scout:
	dw 	jump_goblin_mob:
	dw 	jump_goblin_archers:
	dw 	jump_shadow_faerie:
	dw 	jump_orc:
	dw 	jump_dwarves:
	dw 	jump_little_snakes:
	dw 	jump_troll_trainer:
	dw 	jump_tower_gremlin:
	dw 	jump_full_moon:
	dw 	jump_slasher:
	dw 	jump_ogre:
	dw 	jump_rabid_sheep:
	dw 	jump_imp:
	dw 	jump_spizzer:
	dw 	jump_werewolf:
	dw 	jump_corrosion_cloud:
	dw 	jump_unicorn:
	dw 	jump_elven_archers:
	dw 	jump_succubus:
	dw 	jump_rock_stompers:
	dw 	jump_thief:
	dw 	jump_stone_giant:
	dw 	jump_vampire:
	dw 	jump_dragon:
	dw 	jump_spearman:
	dw 	jump_gnome:
	dw 	jump_berserker:
	dw 	jump_warlord:
	dw 	jump_pegasus_lancer:
map_name_data:	; size: 204 bytes
	dw _brick_shortage_name
	dw _lucky_cache_name
	dw _friendly_terrain_name
	dw _miners_name
	dw _mother_lode_name
	dw _dwarven_miners_name
	dw _work_overtime_name
	dw _copping_the_tech_name
	dw _basic_wall_name
	dw _sturdy_wall_name
	dw _innovations_name
	dw _foundations_name
	dw _tremors_name
	dw _secret_room_name
	dw _earthquake_name
	dw _big_wall_name
	dw _collapse__name
	dw _new_equipment_name
	dw _strip_mine_name
	dw _reinforced_wall_name
	dw _porticulus_name
	dw _crystal_rocks_name
	dw _harmonic_ore_name
	dw _mondo_wall_name
	dw _focused_designs_name
	dw _great_wall_name
	dw _rock_launcher_name
	dw _dragon_s_heart_name
	dw _forced_labor_name
	dw _rock_garden_name
	dw _flood_water_name
	dw _barracks_name
	dw _battlements_name
	dw _shift_name
	dw _quartz_name
	dw _smoky_quartz_name
	dw _amethyst_name
	dw _spell_weavers_name
	dw _prism_name
	dw _lodestone_name
	dw _solar_flare_name
	dw _crystal_matrix_name
	dw _gemstone_flaw_name
	dw _ruby_name
	dw _gem_spear_name
	dw _power_burn_name
	dw _harmonic_vibe_name
	dw _parity_name
	dw _emerald_name
	dw _pearl_of_wisdom_name
	dw _shatterer_name
	dw _crumblestone_name
	dw _sapphire_name
	dw _discord_name
	dw _fire_ruby_name
	dw _quarry_s_help_name
	dw _crystal_shield_name
	dw _empathy_gem_name
	dw _diamond_name
	dw _sanctuary_name
	dw _lava_jewel_name
	dw _dragon_s_eye_name
	dw _crystallize_name
	dw _bag_of_baubles_name
	dw _rainbow_name
	dw _apprentice_name
	dw _lightning_shard_name
	dw _phase_jewel_name
	dw _mad_cow_disease_name
	dw _faerie_name
	dw _moody_goblins_name
	dw _minotaur_name
	dw _elven_scout_name
	dw _goblin_mob_name
	dw _goblin_archers_name
	dw _shadow_faerie_name
	dw _orc_name
	dw _dwarves_name
	dw _little_snakes_name
	dw _troll_trainer_name
	dw _tower_gremlin_name
	dw _full_moon_name
	dw _slasher_name
	dw _ogre_name
	dw _rabid_sheep_name
	dw _imp_name
	dw _spizzer_name
	dw _werewolf_name
	dw _corrosion_cloud_name
	dw _unicorn_name
	dw _elven_archers_name
	dw _succubus_name
	dw _rock_stompers_name
	dw _thief_name
	dw _stone_giant_name
	dw _vampire_name
	dw _dragon_name
	dw _spearman_name
	dw _gnome_name
	dw _berserker_name
	dw _warlord_name
	dw _pegasus_lancer_name
map_card_data:	; size: 204 bytes
	dw _brick_shortage
	dw _lucky_cache
	dw _friendly_terrain
	dw _miners
	dw _mother_lode
	dw _dwarven_miners
	dw _work_overtime
	dw _copping_the_tech
	dw _basic_wall
	dw _sturdy_wall
	dw _innovations
	dw _foundations
	dw _tremors
	dw _secret_room
	dw _earthquake
	dw _big_wall
	dw _collapse_
	dw _new_equipment
	dw _strip_mine
	dw _reinforced_wall
	dw _porticulus
	dw _crystal_rocks
	dw _harmonic_ore
	dw _mondo_wall
	dw _focused_designs
	dw _great_wall
	dw _rock_launcher
	dw _dragon_s_heart
	dw _forced_labor
	dw _rock_garden
	dw _flood_water
	dw _barracks
	dw _battlements
	dw _shift
	dw _quartz
	dw _smoky_quartz
	dw _amethyst
	dw _spell_weavers
	dw _prism
	dw _lodestone
	dw _solar_flare
	dw _crystal_matrix
	dw _gemstone_flaw
	dw _ruby
	dw _gem_spear
	dw _power_burn
	dw _harmonic_vibe
	dw _parity
	dw _emerald
	dw _pearl_of_wisdom
	dw _shatterer
	dw _crumblestone
	dw _sapphire
	dw _discord
	dw _fire_ruby
	dw _quarry_s_help
	dw _crystal_shield
	dw _empathy_gem
	dw _diamond
	dw _sanctuary
	dw _lava_jewel
	dw _dragon_s_eye
	dw _crystallize
	dw _bag_of_baubles
	dw _rainbow
	dw _apprentice
	dw _lightning_shard
	dw _phase_jewel
	dw _mad_cow_disease
	dw _faerie
	dw _moody_goblins
	dw _minotaur
	dw _elven_scout
	dw _goblin_mob
	dw _goblin_archers
	dw _shadow_faerie
	dw _orc
	dw _dwarves
	dw _little_snakes
	dw _troll_trainer
	dw _tower_gremlin
	dw _full_moon
	dw _slasher
	dw _ogre
	dw _rabid_sheep
	dw _imp
	dw _spizzer
	dw _werewolf
	dw _corrosion_cloud
	dw _unicorn
	dw _elven_archers
	dw _succubus
	dw _rock_stompers
	dw _thief
	dw _stone_giant
	dw _vampire
	dw _dragon
	dw _spearman
	dw _gnome
	dw _berserker
	dw _warlord
	dw _pegasus_lancer
map_token_data:	; size: 204 bytes
	dw t__again:
	dw t__all:
	dw t__amt:
	dw t__and:
	dw t__are:
	dw t__be:
	dw t__bricks:
	dw t__can:
	dw t__card:
	dw t__damage:
	dw t__discard:
	dw t__discarded:
	dw t__do:
	dw t__draw:
	dw t__dungeon:
	dw t__else:
	dw t__enemies:
	dw t__enemy:
	dw t__equals:
	dw t__gain:
	dw t__gem:
	dw t__gems:
	dw t__highest:
	dw t__if:
	dw t__it:
	dw t__lose:
	dw t__loses:
	dw t__lowest:
	dw t__magic:
	dw t__play:
	dw t__player:
	dw t__players:
	dw t__playing:
	dw t__quarry:
	dw t__quarrys:
	dw t__recruits:
	dw t__round:
	dw t__six:
	dw t__switch:
	dw t__take:
	dw t__the:
	dw t__this:
	dw t__to:
	dw t__tower:
	dw t__towers:
	dw t__up:
	dw t__wall:
	dw t__walls:
	dw t__with:
	dw t__without:
	dw t__you:
	dw t__your:
card_tokens:	; size: 295 bytes
t__again:
	db "AGAIN", #40
t__all:
	db "ALL", #40
t__amt:
	db "AMT", #40
t__and:
	db "AND", #40
t__are:
	db "ARE", #40
t__be:
	db "BE", #40
t__bricks:
	db "BRICKS", #40
t__can:
	db "CAN", #40
t__card:
	db "CARD", #40
t__damage:
	db "DAMAGE", #40
t__discard:
	db "DISCARD", #40
t__discarded:
	db "DISCARDED", #40
t__do:
	db "DO", #40
t__draw:
	db "DRAW", #40
t__dungeon:
	db "DUNGEON", #40
t__else:
	db "ELSE", #40
t__enemies:
	db "ENEMIES", #40
t__enemy:
	db "ENEMY", #40
t__equals:
	db "EQUALS", #40
t__gain:
	db "GAIN", #40
t__gem:
	db "GEM", #40
t__gems:
	db "GEMS", #40
t__highest:
	db "HIGHEST", #40
t__if:
	db "IF", #40
t__it:
	db "IT", #40
t__lose:
	db "LOSE", #40
t__loses:
	db "LOSES", #40
t__lowest:
	db "LOWEST", #40
t__magic:
	db "MAGIC", #40
t__play:
	db "PLAY", #40
t__player:
	db "PLAYER", #40
t__players:
	db "PLAYERS", #40
t__playing:
	db "PLAYING", #40
t__quarry:
	db "QUARRY", #40
t__quarrys:
	db "QUARRYS", #40
t__recruits:
	db "RECRUITS", #40
t__round:
	db "ROUND", #40
t__six:
	db "SIX", #40
t__switch:
	db "SWITCH", #40
t__take:
	db "TAKE", #40
t__the:
	db "THE", #40
t__this:
	db "THIS", #40
t__to:
	db "TO", #40
t__tower:
	db "TOWER", #40
t__towers:
	db "TOWERS", #40
t__up:
	db "UP", #40
t__wall:
	db "WALL", #40
t__walls:
	db "WALLS", #40
t__with:
	db "WITH", #40
t__without:
	db "WITHOUT", #40
t__you:
	db "YOU", #40
t__your:
	db "YOUR", #40

card_names:	; size: 1144 bytes
_brick_shortage_name:
	db "Brick Shortage", #40
_lucky_cache_name:
	db "Lucky Cache", #40
_friendly_terrain_name:
	db "Friendly Terrain", #40
_miners_name:
	db "Miners", #40
_mother_lode_name:
	db "Mother Lode", #40
_dwarven_miners_name:
	db "Dwarven Miners", #40
_work_overtime_name:
	db "Work Overtime", #40
_copping_the_tech_name:
	db "Copping the Tech", #40
_basic_wall_name:
	db "Basic Wall", #40
_sturdy_wall_name:
	db "Sturdy Wall", #40
_innovations_name:
	db "Innovations", #40
_foundations_name:
	db "Foundations", #40
_tremors_name:
	db "Tremors", #40
_secret_room_name:
	db "Secret Room", #40
_earthquake_name:
	db "Earthquake", #40
_big_wall_name:
	db "Big Wall", #40
_collapse__name:
	db "Collapse!", #40
_new_equipment_name:
	db "New Equipment", #40
_strip_mine_name:
	db "Strip Mine", #40
_reinforced_wall_name:
	db "Reinforced Wall", #40
_porticulus_name:
	db "Porticulus", #40
_crystal_rocks_name:
	db "Crystal Rocks", #40
_harmonic_ore_name:
	db "Harmonic Ore", #40
_mondo_wall_name:
	db "Mondo Wall", #40
_focused_designs_name:
	db "Focused Designs", #40
_great_wall_name:
	db "Great Wall", #40
_rock_launcher_name:
	db "Rock Launcher", #40
_dragon_s_heart_name:
	db "Dragon's Heart", #40
_forced_labor_name:
	db "Forced Labor", #40
_rock_garden_name:
	db "Rock Garden", #40
_flood_water_name:
	db "Flood Water", #40
_barracks_name:
	db "Barracks", #40
_battlements_name:
	db "Battlements", #40
_shift_name:
	db "Shift", #40
_quartz_name:
	db "Quartz", #40
_smoky_quartz_name:
	db "Smoky Quartz", #40
_amethyst_name:
	db "Amethyst", #40
_spell_weavers_name:
	db "Spell Weavers", #40
_prism_name:
	db "Prism", #40
_lodestone_name:
	db "Lodestone", #40
_solar_flare_name:
	db "Solar Flare", #40
_crystal_matrix_name:
	db "Crystal Matrix", #40
_gemstone_flaw_name:
	db "Gemstone Flaw", #40
_ruby_name:
	db "Ruby", #40
_gem_spear_name:
	db "Gem Spear", #40
_power_burn_name:
	db "Power Burn", #40
_harmonic_vibe_name:
	db "Harmonic Vibe", #40
_parity_name:
	db "Parity", #40
_emerald_name:
	db "Emerald", #40
_pearl_of_wisdom_name:
	db "Pearl of Wisdom", #40
_shatterer_name:
	db "Shatterer", #40
_crumblestone_name:
	db "Crumblestone", #40
_sapphire_name:
	db "Sapphire", #40
_discord_name:
	db "Discord", #40
_fire_ruby_name:
	db "Fire Ruby", #40
_quarry_s_help_name:
	db "Quarry's Help", #40
_crystal_shield_name:
	db "Crystal Shield", #40
_empathy_gem_name:
	db "Empathy Gem", #40
_diamond_name:
	db "Diamond", #40
_sanctuary_name:
	db "Sanctuary", #40
_lava_jewel_name:
	db "Lava Jewel", #40
_dragon_s_eye_name:
	db "Dragon's Eye", #40
_crystallize_name:
	db "Crystallize", #40
_bag_of_baubles_name:
	db "Bag of Baubles", #40
_rainbow_name:
	db "Rainbow", #40
_apprentice_name:
	db "Apprentice", #40
_lightning_shard_name:
	db "Lightning Shard", #40
_phase_jewel_name:
	db "Phase Jewel", #40
_mad_cow_disease_name:
	db "Mad Cow Disease", #40
_faerie_name:
	db "Faerie", #40
_moody_goblins_name:
	db "Moody Goblins", #40
_minotaur_name:
	db "Minotaur", #40
_elven_scout_name:
	db "Elven Scout", #40
_goblin_mob_name:
	db "Goblin Mob", #40
_goblin_archers_name:
	db "Goblin Archers", #40
_shadow_faerie_name:
	db "Shadow Faerie", #40
_orc_name:
	db "Orc", #40
_dwarves_name:
	db "Dwarves", #40
_little_snakes_name:
	db "Little Snakes", #40
_troll_trainer_name:
	db "Troll Trainer", #40
_tower_gremlin_name:
	db "Tower Gremlin", #40
_full_moon_name:
	db "Full Moon", #40
_slasher_name:
	db "Slasher", #40
_ogre_name:
	db "Ogre", #40
_rabid_sheep_name:
	db "Rabid Sheep", #40
_imp_name:
	db "Imp", #40
_spizzer_name:
	db "Spizzer", #40
_werewolf_name:
	db "Werewolf", #40
_corrosion_cloud_name:
	db "Corrosion Cloud", #40
_unicorn_name:
	db "Unicorn", #40
_elven_archers_name:
	db "Elven Archers", #40
_succubus_name:
	db "Succubus", #40
_rock_stompers_name:
	db "Rock Stompers", #40
_thief_name:
	db "Thief", #40
_stone_giant_name:
	db "Stone Giant", #40
_vampire_name:
	db "Vampire", #40
_dragon_name:
	db "Dragon", #40
_spearman_name:
	db "Spearman", #40
_gnome_name:
	db "Gnome", #40
_berserker_name:
	db "Berserker", #40
_warlord_name:
	db "Warlord", #40
_pegasus_lancer_name:
	db "Pegasus Lancer", #40
map_card_cost:
cost_brick_shortage:
	db 0
cost_lucky_cache:
	db 0
cost_friendly_terrain:
	db 1
cost_miners:
	db 3
cost_mother_lode:
	db 4
cost_dwarven_miners:
	db 7
cost_work_overtime:
	db 2
cost_copping_the_tech:
	db 5
cost_basic_wall:
	db 2
cost_sturdy_wall:
	db 3
cost_innovations:
	db 2
cost_foundations:
	db 3
cost_tremors:
	db 7
cost_secret_room:
	db 8
cost_earthquake:
	db 0
cost_big_wall:
	db 5
cost_collapse_:
	db 4
cost_new_equipment:
	db 6
cost_strip_mine:
	db 0
cost_reinforced_wall:
	db 8
cost_porticulus:
	db 9
cost_crystal_rocks:
	db 9
cost_harmonic_ore:
	db 11
cost_mondo_wall:
	db 13
cost_focused_designs:
	db 15
cost_great_wall:
	db 16
cost_rock_launcher:
	db 18
cost_dragon_s_heart:
	db 24
cost_forced_labor:
	db 7
cost_rock_garden:
	db 1
cost_flood_water:
	db 6
cost_barracks:
	db 10
cost_battlements:
	db 14
cost_shift:
	db 17
cost_quartz:
	db 1
cost_smoky_quartz:
	db 2
cost_amethyst:
	db 2
cost_spell_weavers:
	db 3
cost_prism:
	db 2
cost_lodestone:
	db 5
cost_solar_flare:
	db 4
cost_crystal_matrix:
	db 6
cost_gemstone_flaw:
	db 2
cost_ruby:
	db 3
cost_gem_spear:
	db 4
cost_power_burn:
	db 3
cost_harmonic_vibe:
	db 7
cost_parity:
	db 7
cost_emerald:
	db 6
cost_pearl_of_wisdom:
	db 9
cost_shatterer:
	db 8
cost_crumblestone:
	db 7
cost_sapphire:
	db 10
cost_discord:
	db 5
cost_fire_ruby:
	db 13
cost_quarry_s_help:
	db 4
cost_crystal_shield:
	db 12
cost_empathy_gem:
	db 14
cost_diamond:
	db 16
cost_sanctuary:
	db 15
cost_lava_jewel:
	db 17
cost_dragon_s_eye:
	db 21
cost_crystallize:
	db 8
cost_bag_of_baubles:
	db 0
cost_rainbow:
	db 0
cost_apprentice:
	db 5
cost_lightning_shard:
	db 11
cost_phase_jewel:
	db 18
cost_mad_cow_disease:
	db 0
cost_faerie:
	db 1
cost_moody_goblins:
	db 1
cost_minotaur:
	db 3
cost_elven_scout:
	db 2
cost_goblin_mob:
	db 3
cost_goblin_archers:
	db 4
cost_shadow_faerie:
	db 6
cost_orc:
	db 3
cost_dwarves:
	db 5
cost_little_snakes:
	db 6
cost_troll_trainer:
	db 7
cost_tower_gremlin:
	db 8
cost_full_moon:
	db 0
cost_slasher:
	db 5
cost_ogre:
	db 6
cost_rabid_sheep:
	db 6
cost_imp:
	db 5
cost_spizzer:
	db 8
cost_werewolf:
	db 9
cost_corrosion_cloud:
	db 11
cost_unicorn:
	db 9
cost_elven_archers:
	db 10
cost_succubus:
	db 14
cost_rock_stompers:
	db 11
cost_thief:
	db 12
cost_stone_giant:
	db 15
cost_vampire:
	db 17
cost_dragon:
	db 25
cost_spearman:
	db 2
cost_gnome:
	db 2
cost_berserker:
	db 4
cost_warlord:
	db 13
cost_pegasus_lancer:
	db 18

;	card data size: 1512 bytes
;	Хранение данных карт для отрисовки и обработки:
;	Занчения:
;	0-31 цифровые значения
;	32-126 символы
;	128-179 токены
;	#40 (@) завершающий символ
_brick_shortage:
	;ALL PLAYERS LOSE 8 BRICKS.
	db	#81, #20, #9F, #20, #99, #20, #08, #20, #86, #2E, #40
_lucky_cache:
	;+2 BRICKS, +2 GEMS, PLAY AGAIN.
	db	#2B, #02, #20, #86, #2C, #20, #2B, #02, #20, #95, #2C, #20, #9D, #20, #80, #2E, #40
_friendly_terrain:
	;+1 WALL. PLAY AGAIN.
	db	#2B, #01, #20, #AE, #2E, #20, #9D, #20, #80, #2E, #40
_miners:
	;+1 QUARRY.
	db	#2B, #01, #20, #A1, #2E, #40
_mother_lode:
	;IF QUARRY < ENEMY QUARRY, +2 QUARRY. ELSE, +1 QUARRY.
	db	#97, #20, #A1, #20, #3C, #20, #91, #20, #A1, #2C, #20, #2B, #02, #20, #A1, #2E, #20, #8F, #2C, #20, #2B, #01, #20, #A1, #2E, #40
_dwarven_miners:
	;+4 WALL, +1 QUARRY.
	db	#2B, #04, #20, #AE, #2C, #20, #2B, #01, #20, #A1, #2E, #40
_work_overtime:
	;+5 WALL. YOU LOSE SIX GEMS.
	db	#2B, #05, #20, #AE, #2E, #20, #B2, #20, #99, #20, #A5, #20, #95, #2E, #40
_copping_the_tech:
	;IF QUARRY < ENEMY QUARRY, QUARRY = ENEMY QUARRY.
	db	#97, #20, #A1, #20, #3C, #20, #91, #20, #A1, #2C, #20, #A1, #20, #3D, #20, #91, #20, #A1, #2E, #40
_basic_wall:
	;+3 WALL.
	db	#2B, #03, #20, #AE, #2E, #40
_sturdy_wall:
	;+4 WALL.
	db	#2B, #04, #20, #AE, #2E, #40
_innovations:
	;+1 TO ALL PLAYER'S QUARRYS, YOU GAIN 4 GEMS.
	db	#2B, #01, #20, #AA, #20, #81, #20, #9E, #27, #53, #20, #A2, #2C, #20, #B2, #20, #93, #20, #04, #20, #95, #2E, #40
_foundations:
	;IF WALL = 0, +6 WALL, ELSE +3 WALL.
	db	#97, #20, #AE, #20, #3D, #20, #00, #2C, #20, #2B, #06, #20, #AE, #2C, #20, #8F, #20, #2B, #03, #20, #AE, #2E, #40
_tremors:
	;ALL WALLS TAKE 5 DAMAGE. PLAY AGAIN.
	db	#81, #20, #AF, #20, #A7, #20, #05, #20, #89, #2E, #20, #9D, #20, #80, #2E, #40
_secret_room:
	;+1 MAGIC. PLAY AGAIN.
	db	#2B, #01, #20, #9C, #2E, #20, #9D, #20, #80, #2E, #40
_earthquake:
	;-1 TO ALL PLAYER'S QUARRYS.
	db	#2D, #01, #20, #AA, #20, #81, #20, #9E, #27, #53, #20, #A2, #2E, #40
_big_wall:
	;+6 WALL.
	db	#2B, #06, #20, #AE, #2E, #40
_collapse_:
	;-1 ENEMY QUARRY.
	db	#2D, #01, #20, #91, #20, #A1, #2E, #40
_new_equipment:
	;+2 QUARRY.
	db	#2B, #02, #20, #A1, #2E, #40
_strip_mine:
	;-1 QUARRY, +10 WALL. YOU GAIN 5 GEMS.
	db	#2D, #01, #20, #A1, #2C, #20, #2B, #0A, #20, #AE, #2E, #20, #B2, #20, #93, #20, #05, #20, #95, #2E, #40
_reinforced_wall:
	;+8 WALL.
	db	#2B, #08, #20, #AE, #2E, #40
_porticulus:
	;+5 WALL, +1 DUNGEON.
	db	#2B, #05, #20, #AE, #2C, #20, #2B, #01, #20, #8E, #2E, #40
_crystal_rocks:
	;+7 WALL, GAIN 7 GEMS.
	db	#2B, #07, #20, #AE, #2C, #20, #93, #20, #07, #20, #95, #2E, #40
_harmonic_ore:
	;+6 WALL, +3 TOWER.
	db	#2B, #06, #20, #AE, #2C, #20, #2B, #03, #20, #AB, #2E, #40
_mondo_wall:
	;+12 WALL.
	db	#2B, #0C, #20, #AE, #2E, #40
_focused_designs:
	;+8 WALL, +5 TOWER.
	db	#2B, #08, #20, #AE, #2C, #20, #2B, #05, #20, #AB, #2E, #40
_great_wall:
	;+15 WALL.
	db	#2B, #0F, #20, #AE, #2E, #40
_rock_launcher:
	;+6 WALL. 10 DAMAGE TO ENEMY.
	db	#2B, #06, #20, #AE, #2E, #20, #0A, #20, #89, #20, #AA, #20, #91, #2E, #40
_dragon_s_heart:
	;+20 WALL, +8 TOWER.
	db	#2B, #14, #20, #AE, #2C, #20, #2B, #08, #20, #AB, #2E, #40
_forced_labor:
	;+9 WALL, LOSE 5 RECRUITS.
	db	#2B, #09, #20, #AE, #2C, #20, #99, #20, #05, #20, #A3, #2E, #40
_rock_garden:
	;+1 WALL, +1 TOWER, +2 RECRUITS.
	db	#2B, #01, #20, #AE, #2C, #20, #2B, #01, #20, #AB, #2C, #20, #2B, #02, #20, #A3, #2E, #40
_flood_water:
	;PLAYER(S) W/LOWEST WALL ARE -1 DUNGEON AND 2 DAMAGE TO TOWER.
	db	#9E, #28, #53, #29, #20, #57, #2F, #9B, #20, #AE, #20, #84, #20, #2D, #01, #20, #8E, #20, #83, #20, #02, #20, #89, #20, #AA, #20, #AB, #2E, #40
_barracks:
	;+6 RECRUITS, +6 WALL. IF DUNGEON < ENEMY DUNGEON, +1 DUNGEON.
	db	#2B, #06, #20, #A3, #2C, #20, #2B, #06, #20, #AE, #2E, #20, #97, #20, #8E, #20, #3C, #20, #91, #20, #8E, #2C, #20, #2B, #01, #20, #8E, #2E, #40
_battlements:
	;+7 WALL, 6 DAMAGE TO ENEMY.
	db	#2B, #07, #20, #AE, #2C, #20, #06, #20, #89, #20, #AA, #20, #91, #2E, #40
_shift:
	;SWITCH YOUR WALL WITH ENEMY WALL.
	db	#A6, #20, #B3, #20, #AE, #20, #B0, #20, #91, #20, #AE, #2E, #40
_quartz:
	;+1 TOWER. PLAY AGAIN.
	db	#2B, #01, #20, #AB, #2E, #20, #9D, #20, #80, #2E, #40
_smoky_quartz:
	;1 DAMAGE TO ENEMY TOWER. PLAY AGAIN.
	db	#01, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #20, #9D, #20, #80, #2E, #40
_amethyst:
	;+3 TOWER.
	db	#2B, #03, #20, #AB, #2E, #40
_spell_weavers:
	;+1 MAGIC.
	db	#2B, #01, #20, #9C, #2E, #40
_prism:
	;DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.
	db	#8D, #20, #01, #20, #88, #2E, #20, #8A, #20, #01, #20, #88, #2E, #20, #9D, #20, #80, #2E, #40
_lodestone:
	;+8 TOWER. THIS CARD CAN'T BE DISCARDED WITHOUT PLAYING IT.
	db	#2B, #08, #20, #AB, #2E, #20, #A9, #20, #88, #20, #87, #27, #54, #20, #85, #20, #8B, #20, #B1, #20, #A0, #20, #98, #2E, #40
_solar_flare:
	;+2 TOWER. 2 DAMAGE TO ENEMY TOWER.
	db	#2B, #02, #20, #AB, #2E, #20, #02, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
_crystal_matrix:
	;+1 MAGIC. +3 TOWER. +1 ENEMY TOWER.
	db	#2B, #01, #20, #9C, #2E, #20, #2B, #03, #20, #AB, #2E, #20, #2B, #01, #20, #91, #20, #AB, #2E, #40
_gemstone_flaw:
	;3 DAMAGE TO ENEMY TOWER.
	db	#03, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
_ruby:
	;+5 TOWER.
	db	#2B, #05, #20, #AB, #2E, #40
_gem_spear:
	;5 DAMAGE TO ENEMY TOWER.
	db	#05, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
_power_burn:
	;5 DAMAGE TO YOUR TOWER. +2 MAGIC.
	db	#05, #20, #89, #20, #AA, #20, #B3, #20, #AB, #2E, #20, #2B, #02, #20, #9C, #2E, #40
_harmonic_vibe:
	;+1 MAGIC. +3 TOWER. +3 WALL.
	db	#2B, #01, #20, #9C, #2E, #20, #2B, #03, #20, #AB, #2E, #20, #2B, #03, #20, #AE, #2E, #40
_parity:
	;ALL PLAYER'S MAGIC EQUALS THE HIGHEST PLAYER'S MAGIC.
	db	#81, #20, #9E, #27, #53, #20, #9C, #20, #92, #20, #A8, #20, #96, #20, #9E, #27, #53, #20, #9C, #2E, #40
_emerald:
	;+8 TOWER.
	db	#2B, #08, #20, #AB, #2E, #40
_pearl_of_wisdom:
	;+5 TOWER. +1 MAGIC.
	db	#2B, #05, #20, #AB, #2E, #20, #2B, #01, #20, #9C, #2E, #40
_shatterer:
	;-1 MAGIC. 9 DAMAGE TO ENEMY TOWER.
	db	#2D, #01, #20, #9C, #2E, #20, #09, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
_crumblestone:
	;+5 TOWER. ENEMY LOSES 6 BRICKS.
	db	#2B, #05, #20, #AB, #2E, #20, #91, #20, #9A, #20, #06, #20, #86, #2E, #40
_sapphire:
	;+11 TOWER.
	db	#2B, #0B, #20, #AB, #2E, #40
_discord:
	;7 DAMAGE TO ALL TOWERS, ALL PLAYERS MAGIC -1
	db	#07, #20, #89, #20, #AA, #20, #81, #20, #AC, #2C, #20, #81, #20, #9F, #20, #9C, #20, #2D, #01, #40
_fire_ruby:
	;+6 TOWER. 4 DAMAGE TO ALL ENEMY TOWERS.
	db	#2B, #06, #20, #AB, #2E, #20, #04, #20, #89, #20, #AA, #20, #81, #20, #91, #20, #AC, #2E, #40
_quarry_s_help:
	;+7 TOWER. LOSE 10 BRICKS.
	db	#2B, #07, #20, #AB, #2E, #20, #99, #20, #0A, #20, #86, #2E, #40
_crystal_shield:
	;+8 TOWER. +3 WALL.
	db	#2B, #08, #20, #AB, #2E, #20, #2B, #03, #20, #AE, #2E, #40
_empathy_gem:
	;+8 TOWER. +1 DUNGEON.
	db	#2B, #08, #20, #AB, #2E, #20, #2B, #01, #20, #8E, #2E, #40
_diamond:
	;+15 TOWER.
	db	#2B, #0F, #20, #AB, #2E, #40
_sanctuary:
	;+10 TOWER. +5 WALL, GAIN 5 RECRUITS.
	db	#2B, #0A, #20, #AB, #2E, #20, #2B, #05, #20, #AE, #2C, #20, #93, #20, #05, #20, #A3, #2E, #40
_lava_jewel:
	;+12 TOWER. 6 DAMAGE TO ALL ENEMIES.
	db	#2B, #0C, #20, #AB, #2E, #20, #06, #20, #89, #20, #AA, #20, #81, #20, #90, #2E, #40
_dragon_s_eye:
	;+20 TOWER.
	db	#2B, #14, #20, #AB, #2E, #40
_crystallize:
	;+11 TOWER. -6 WALL.
	db	#2B, #0B, #20, #AB, #2E, #20, #2D, #06, #20, #AE, #2E, #40
_bag_of_baubles:
	;IF TOWER < ENEMY TOWER, +2 TOWER. ELSE +1 TOWER.
	db	#97, #20, #AB, #20, #3C, #20, #91, #20, #AB, #2C, #20, #2B, #02, #20, #AB, #2E, #20, #8F, #20, #2B, #01, #20, #AB, #2E, #40
_rainbow:
	;+1 TOWER TO ALL PLAYERS. YOU GAIN 3 GEMS.
	db	#2B, #01, #20, #AB, #20, #AA, #20, #81, #20, #9F, #2E, #20, #B2, #20, #93, #20, #03, #20, #95, #2E, #40
_apprentice:
	;+4 TOWER, YOU LOSE 3 RECRUITS, 2 DAMAGE TO ENEMY TOWER.
	db	#2B, #04, #20, #AB, #2C, #20, #B2, #20, #99, #20, #03, #20, #A3, #2C, #20, #02, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
_lightning_shard:
	;IF TOWER < ENEMY WALL, 8 DAMAGE TO ENEMY TOWER. ELSE 8 DAMAGE.
	db	#97, #20, #AB, #20, #3C, #20, #91, #20, #AE, #2C, #20, #08, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #20, #8F, #20, #08, #20, #89, #2E, #40
_phase_jewel:
	;+13 TOWER. +6 RECRUITS. +6 BRICKS.
	db	#2B, #0D, #20, #AB, #2E, #20, #2B, #06, #20, #A3, #2E, #20, #2B, #06, #20, #86, #2E, #40
_mad_cow_disease:
	;ALL PLAYERS LOSE 6 RECRUITS.
	db	#81, #20, #9F, #20, #99, #20, #06, #20, #A3, #2E, #40
_faerie:
	;2 DAMAGE. PLAY AGAIN.
	db	#02, #20, #89, #2E, #20, #9D, #20, #80, #2E, #40
_moody_goblins:
	;4 DAMAGE. YOU LOSE 3 GEMS.
	db	#04, #20, #89, #2E, #20, #B2, #20, #99, #20, #03, #20, #95, #2E, #40
_minotaur:
	;+1 DUNGEON.
	db	#2B, #01, #20, #8E, #2E, #40
_elven_scout:
	;DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.
	db	#8D, #20, #01, #20, #88, #2E, #20, #8A, #20, #01, #20, #88, #2E, #20, #9D, #20, #80, #2E, #40
_goblin_mob:
	;6 DAMAGE. YOU TAKE 3 DAMAGE.
	db	#06, #20, #89, #2E, #20, #B2, #20, #A7, #20, #03, #20, #89, #2E, #40
_goblin_archers:
	;3 DAMAGE TO ENEMY TOWER. YOU TAKE 1 DAMAGE.
	db	#03, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #20, #B2, #20, #A7, #20, #01, #20, #89, #2E, #40
_shadow_faerie:
	;2 DAMAGE TO ENEMY TOWER. PLAY AGAIN.
	db	#02, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #20, #9D, #20, #80, #2E, #40
_orc:
	;5 DAMAGE.
	db	#05, #20, #89, #2E, #40
_dwarves:
	;4 DAMAGE. +3 WALL.
	db	#04, #20, #89, #2E, #20, #2B, #03, #20, #AE, #2E, #40
_little_snakes:
	;4 DAMAGE TO ENEMY TOWER.
	db	#04, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
_troll_trainer:
	;+2 DUNGEON.
	db	#2B, #02, #20, #8E, #2E, #40
_tower_gremlin:
	;2 DAMAGE. +4 TOWER. +2 WALL.
	db	#02, #20, #89, #2E, #20, #2B, #04, #20, #AB, #2E, #20, #2B, #02, #20, #AE, #2E, #40
_full_moon:
	;+1 TO ALL PLAYER'S DUNGEON. YOU GAIN 3 RECRUITS.
	db	#2B, #01, #20, #AA, #20, #81, #20, #9E, #27, #53, #20, #8E, #2E, #20, #B2, #20, #93, #20, #03, #20, #A3, #2E, #40
_slasher:
	;6 DAMAGE.
	db	#06, #20, #89, #2E, #40
_ogre:
	;7 DAMAGE.
	db	#07, #20, #89, #2E, #40
_rabid_sheep:
	;6 DAMAGE. ENEMY LOSES 3 RECRUITS.
	db	#06, #20, #89, #2E, #20, #91, #20, #9A, #20, #03, #20, #A3, #2E, #40
_imp:
	;6 DAMAGE. ALL PLAYERS LOSE 5 BRICKS, GEMS AND RECRUITS.
	db	#06, #20, #89, #2E, #20, #81, #20, #9F, #20, #99, #20, #05, #20, #86, #2C, #20, #95, #20, #83, #20, #A3, #2E, #40
_spizzer:
	;IF ENEMY WALL = 0, 10 DAMAGE, ELSE 6 DAMAGE.
	db	#97, #20, #91, #20, #AE, #20, #3D, #20, #00, #2C, #20, #0A, #20, #89, #2C, #20, #8F, #20, #06, #20, #89, #2E, #40
_werewolf:
	;9 DAMAGE.
	db	#09, #20, #89, #2E, #40
_corrosion_cloud:
	;IF ENEMY WALL > 0, 10 DAMAGE, ELSE 7 DAMAGE.
	db	#97, #20, #91, #20, #AE, #20, #3E, #20, #00, #2C, #20, #0A, #20, #89, #2C, #20, #8F, #20, #07, #20, #89, #2E, #40
_unicorn:
	;IF MAGIC > ENEMY MAGIC, 12 DAMAGE, ELSE 8 DAMAGE.
	db	#97, #20, #9C, #20, #3E, #20, #91, #20, #9C, #2C, #20, #0C, #20, #89, #2C, #20, #8F, #20, #08, #20, #89, #2E, #40
_elven_archers:
	;IF WALL > ENEMY WALL, 6 DAMAGE TO ENEMY TOWER, ELSE 6 DAMAGE.
	db	#97, #20, #AE, #20, #3E, #20, #91, #20, #AE, #2C, #20, #06, #20, #89, #20, #AA, #20, #91, #20, #AB, #2C, #20, #8F, #20, #06, #20, #89, #2E, #40
_succubus:
	;5 DAMAGE TO ENEMY TOWER, ENEMY LOSES 8 RECRUITS.
	db	#05, #20, #89, #20, #AA, #20, #91, #20, #AB, #2C, #20, #91, #20, #9A, #20, #08, #20, #A3, #2E, #40
_rock_stompers:
	;8 DAMAGE, -1 ENEMY QUARRY.
	db	#08, #20, #89, #2C, #20, #2D, #01, #20, #91, #20, #A1, #2E, #40
_thief:
	;ENEMY LOSES 10 GEMS, 5 BRICKS, YOU GAIN 1/2 AMT. ROUND UP.
	db	#91, #20, #9A, #20, #0A, #20, #95, #2C, #20, #05, #20, #86, #2C, #20, #B2, #20, #93, #20, #01, #2F, #02, #20, #82, #2E, #20, #A4, #20, #AD, #2E, #40
_stone_giant:
	;10 DAMAGE. +4 WALL.
	db	#0A, #20, #89, #2E, #20, #2B, #04, #20, #AE, #2E, #40
_vampire:
	;10 DAMAGE. ENEMY LOSES 5 RECRUITS, -1 ENEMY DUNGEON.
	db	#0A, #20, #89, #2E, #20, #91, #20, #9A, #20, #05, #20, #A3, #2C, #20, #2D, #01, #20, #91, #20, #8E, #2E, #40
_dragon:
	;20 DAMAGE. ENEMY LOSES 10 GEMS, -1 ENEMY DUNGEON.
	db	#14, #20, #89, #2E, #20, #91, #20, #9A, #20, #0A, #20, #95, #2C, #20, #2D, #01, #20, #91, #20, #8E, #2E, #40
_spearman:
	;IF WALL > ENEMY WALL DO 3 DAMAGE ELSE DO 2 DAMAGE.
	db	#97, #20, #AE, #20, #3E, #20, #91, #20, #AE, #20, #8C, #20, #03, #20, #89, #20, #8F, #20, #8C, #20, #02, #20, #89, #2E, #40
_gnome:
	;3 DAMAGE. +1 GEM.
	db	#03, #20, #89, #2E, #20, #2B, #01, #20, #94, #2E, #40
_berserker:
	;8 DAMAGE. 3 DAMAGE TO YOUR TOWER.
	db	#08, #20, #89, #2E, #20, #03, #20, #89, #20, #AA, #20, #B3, #20, #AB, #2E, #40
_warlord:
	;13 DAMAGE. YOU LOSE 3 GEMS.
	db	#0D, #20, #89, #2E, #20, #B2, #20, #99, #20, #03, #20, #95, #2E, #40
_pegasus_lancer:
	;12 DAMAGE TO ENEMY TOWER.
	db	#0C, #20, #89, #20, #AA, #20, #91, #20, #AB, #2E, #40
