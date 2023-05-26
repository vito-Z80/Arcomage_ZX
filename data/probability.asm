//	вероятность выпадения карт.
//	https://github.com/arcomage/arcomage-hd/blob/main/src/data/cards.ts - значения взяты отсюда и инвертированы.
//	https://rpgwatch.com/forum/threads/arcomage.326/page-2#post-5003
//	https://vc.ru/flood/13255-game-balance-5

;	+ Таблица вероятностей (не изменяемая):
;	+ 1 - карта выпадает сразу.
;	+ 3 - карта выпадает через 3 обращения.
;	+ 
;	+ Работает следующим образом:
;	+ 1) Рандомно получаем индекс карты для выдачи одному из игроков.
;	+ 2) По инедексу получаем значение вероятности.
;	+ lucky_cache = 3
;	+ 3) Декрементим значение вероятности. Если значение = 0, то эта карта будет выдана игроку, иначе сохраняем новое значение и переходим к пункту 1)
;	+ То есть, прежде чем получить такую карту необходимо что бы рандом 3 раза выбрал индекс этой карты.
;	+ После получения такой карты значение вероятности восстанавливается и в данном случае будет = 3.
probability_map:
prob_brick_shortage:	db 1	; ALL PLAYERS LOSE 8 BRICKS.
prob_lucky_cache:	db 3	; +2 BRICKS, +2 GEMS, PLAY AGAIN.
prob_friendly_terrain:	db 2	; +1 WALL. PLAY AGAIN.
prob_miners:		db 1	; +1 QUARRY.
prob_mother_lode:	db 1	; IF QUARRY < ENEMY QUARRY, +2 QUARRY. ELSE, +1 QUARRY.
prob_dwarven_miners:	db 2	; +4 WALL, +1 QUARRY.
prob_work_overtime:	db 1	; +5 WALL. YOU LOSE SIX GEMS.
prob_copping_the_tech:	db 2	; IF QUARRY < ENEMY QUARRY, QUARRY = ENEMY QUARRY.
prob_basic_wall:	db 1	; +3 WALL.
prob_sturdy_wall:	db 2	; +4 WALL.
prob_innovations:	db 1	; +1 TO ALL PLAYER'S QUARRYS, YOU GAIN 4 GEMS.
prob_foundations:	db 1	; IF WALL = 0, +6 WALL, ELSE +3 WALL.
prob_tremors:		db 2	; ALL WALLS TAKE 5 DAMAGE. PLAY AGAIN.
prob_secret_room:	db 3	; +1 MAGIC. PLAY AGAIN.
prob_earthquake:	db 1	; -1 TO ALL PLAYER'S QUARRYS.
prob_big_wall:		db 1	; +6 WALL.
prob_collapse_:		db 2	; -1 ENEMY QUARRY.
prob_new_equipment:	db 2	; +2 QUARRY.
prob_strip_mine:	db 2	; -1 QUARRY, +10 WALL. YOU GAIN 5 GEMS.
prob_reinforced_wall:	db 1	; +8 WALL.
prob_porticulus:	db 2	; +5 WALL, +1 DUNGEON.
prob_crystal_rocks:	db 2	; +7 WALL, GAIN 7 GEMS.
prob_harmonic_ore:	db 2	; +6 WALL, +3 TOWER.
prob_mondo_wall:	db 2	; +12 WALL.
prob_focused_designs:	db 2	; +8 WALL, +5 TOWER.
prob_great_wall:	db 2	; +15 WALL.
prob_rock_launcher:	db 2	; +6 WALL. 10 DAMAGE TO ENEMY.
prob_dragon_s_heart:	db 2	; +20 WALL, +8 TOWER.
prob_forced_labor:	db 2	; +9 WALL, LOSE 5 RECRUITS.
prob_rock_garden:	db 2	; +1 WALL, +1 TOWER, +2 RECRUITS.
prob_flood_water:	db 1	; PLAYER(S) W/LOWEST WALL ARE -1 DUNGEON AND 2 DAMAGE TO TOWER.
prob_barracks:		db 2	; +6 RECRUITS, +6 WALL. IF DUNGEON < ENEMY DUNGEON, +1 DUNGEON.
prob_battlements:	db 2	; +7 WALL, 6 DAMAGE TO ENEMY.
prob_shift:		db 2	; SWITCH YOUR WALL WITH ENEMY WALL.
prob_quartz:		db 2	; +1 TOWER. PLAY AGAIN.
prob_smoky_quartz:	db 2	; 1 DAMAGE TO ENEMY TOWER. PLAY AGAIN.
prob_amethyst:		db 1	; +3 TOWER.
prob_spell_weavers:	db 2	; +1 MAGIC.
prob_prism:		db 3	; DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.
prob_lodestone:		db 2	; +8 TOWER. THIS CARD CAN'T BE DISCARDED WITHOUT PLAYING IT.
prob_solar_flare:	db 1	; +2 TOWER. 2 DAMAGE TO ENEMY TOWER.
prob_crystal_matrix:	db 2	; +1 MAGIC. +3 TOWER. +1 ENEMY TOWER.
prob_gemstone_flaw:	db 1	; 3 DAMAGE TO ENEMY TOWER.
prob_ruby:		db 1	; +5 TOWER.
prob_gem_spear:		db 1	; 5 DAMAGE TO ENEMY TOWER.
prob_power_burn:	db 2	; 5 DAMAGE TO YOUR TOWER. +2 MAGIC.
prob_harmonic_vibe:	db 2	; +1 MAGIC. +3 TOWER. +3 WALL.
prob_parity:		db 2	; ALL PLAYER'S MAGIC EQUALS THE HIGHEST PLAYER'S MAGIC.
prob_emerald:		db 2	; +8 TOWER.
prob_pearl_of_wisdom:	db 2	; +5 TOWER. +1 MAGIC.
prob_shatterer:		db 1	; -1 MAGIC. 9 DAMAGE TO ENEMY TOWER.
prob_crumblestone:	db 2	; +5 TOWER. ENEMY LOSES 6 BRICKS.
prob_sapphire:		db 2	; +11 TOWER.
prob_discord:		db 1	; 7 DAMAGE TO ALL TOWERS, ALL PLAYERS MAGIC -1
prob_fire_ruby:		db 2	; +6 TOWER. 4 DAMAGE TO ALL ENEMY TOWERS.
prob_quarry_s_help:	db 2	; +7 TOWER. LOSE 10 BRICKS.
prob_crystal_shield:	db 2	; +8 TOWER. +3 WALL.
prob_empathy_gem:	db 2	; +8 TOWER. +1 DUNGEON.
prob_diamond:		db 2	; +15 TOWER.
prob_sanctuary:		db 2	; +10 TOWER. +5 WALL, GAIN 5 RECRUITS.
prob_lava_jewel:	db 2	; +12 TOWER. 6 DAMAGE TO ALL ENEMIES.
prob_dragon_s_eye:	db 2	; +20 TOWER.
prob_crystallize:	db 2	; +11 TOWER. -6 WALL.
prob_bag_of_baubles:	db 2	; IF TOWER < ENEMY TOWER, +2 TOWER. ELSE +1 TOWER.
prob_rainbow:		db 2	; +1 TOWER TO ALL PLAYERS. YOU GAIN 3 GEMS.
prob_apprentice:	db 1	; +4 TOWER, YOU LOSE 3 RECRUITS, 2 DAMAGE TO ENEMY TOWER.
prob_lightning_shard:	db 2	; IF TOWER < ENEMY WALL, 8 DAMAGE TO ENEMY TOWER. ELSE 8 DAMAGE.
prob_phase_jewel:	db 2	; +13 TOWER. +6 RECRUITS. +6 BRICKS.
prob_mad_cow_disease:	db 2	; ALL PLAYERS LOSE 6 RECRUITS.
prob_faerie:		db 3	; 2 DAMAGE. PLAY AGAIN.
prob_moody_goblins:	db 1	; 4 DAMAGE. YOU LOSE 3 GEMS.
prob_minotaur:		db 2	; +1 DUNGEON.
prob_elven_scout:	db 3	; DRAW 1 CARD. DISCARD 1 CARD. PLAY AGAIN.
prob_goblin_mob:	db 1	; 6 DAMAGE. YOU TAKE 3 DAMAGE.
prob_goblin_archers:	db 2	; 3 DAMAGE TO ENEMY TOWER. YOU TAKE 1 DAMAGE.
prob_shadow_faerie:	db 2	; 2 DAMAGE TO ENEMY TOWER. PLAY AGAIN.
prob_orc:		db 1	; 5 DAMAGE.
prob_dwarves:		db 1	; 4 DAMAGE. +3 WALL.
prob_little_snakes:	db 1	; 4 DAMAGE TO ENEMY TOWER.
prob_troll_trainer:	db 1	; +2 DUNGEON.
prob_tower_gremlin:	db 2	; 2 DAMAGE. +4 TOWER. +2 WALL.
prob_full_moon:		db 2	; +1 TO ALL PLAYER'S DUNGEON. YOU GAIN 3 RECRUITS.
prob_slasher:		db 1	; 6 DAMAGE.
prob_ogre:		db 1	; 7 DAMAGE.
prob_rabid_sheep:	db 1	; 6 DAMAGE. ENEMY LOSES 3 RECRUITS.
prob_imp:		db 1	; 6 DAMAGE. ALL PLAYERS LOSE 5 BRICKS, GEMS AND RECRUITS.
prob_spizzer:		db 2	; IF ENEMY WALL = 0, 10 DAMAGE, ELSE 6 DAMAGE.
prob_werewolf:		db 2	; 9 DAMAGE.
prob_corrosion_cloud:	db 2	; IF ENEMY WALL > 0, 10 DAMAGE, ELSE 7 DAMAGE.
prob_unicorn:		db 2	; IF MAGIC > ENEMY MAGIC, 12 DAMAGE, ELSE 8 DAMAGE.
prob_elven_archers:	db 2	; IF WALL > ENEMY WALL, 6 DAMAGE TO ENEMY TOWER, ELSE 6 DAMAGE.
prob_succubus:		db 2	; 5 DAMAGE TO ENEMY TOWER, ENEMY LOSES 8 RECRUITS.
prob_rock_stompers:	db 2	; 8 DAMAGE, -1 ENEMY QUARRY.
prob_thief:		db 2	; ENEMY LOSES 10 GEMS, 5 BRICKS, YOU GAIN 1/2 AMT. ROUND UP.
prob_stone_giant:	db 2	; 10 DAMAGE. +4 WALL.
prob_vampire:		db 2	; 10 DAMAGE. ENEMY LOSES 5 RECRUITS, -1 ENEMY DUNGEON.
prob_dragon:		db 2	; 20 DAMAGE. ENEMY LOSES 10 GEMS, -1 ENEMY DUNGEON.
prob_spearman:		db 1	; IF WALL > ENEMY WALL DO 3 DAMAGE ELSE DO 2 DAMAGE.
prob_gnome:		db 1	; 3 DAMAGE. +1 GEM.
prob_berserker:		db 1	; 8 DAMAGE. 3 DAMAGE TO YOUR TOWER.
prob_warlord:		db 2	; 13 DAMAGE. YOU LOSE 3 GEMS.
prob_pegasus_lancer:	db 2	; 12 DAMAGE TO ENEMY TOWER.