pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- initialize game state
player_hp = 10
title = true
enemy_hp = 3
xpos = 5
ypos = 70
input_delay = 5
input_timer = 0
enemy_name = "dark_z"
player_turn = true
turn_timer = 0
message = ""
inv = false
lvl = 1
menu = true
mag = false
max_hp = 10
max_sp = 30
on_guard = false
cmenu = false
char = "makoto"
player_weak = "pierce"
player_resist = "fire"
melee = "slash"
player_sp = 30
enemies_defeated = 0
enemy_power = 2
enemy_type = "dark"
enemy_weak = "light"

function _update()
	if title == true then
		_screen()
	elseif title == false then
		_update_game()
	end
end

function _screen()
	if btnp(4) then
		title = false
	end
end

function _draw()
	cls()
  if title then
    draw_title_screen()
  elseif title == false then
    _draw_game() -- rename your current _draw() logic to this
  end
end

function draw_title_screen()
		print("eon spar", 20, 30, 7)
  print("press alt+z to start", 20, 50, 7)
  print("use up/down to move", 20, 70, 7)
		print("use alt+z and alt+x as y/n",20,90,7)
end
		
		

function _update_game()
	if player_hp <= 0 then
			xpos = 5
			ypos = 70
			input_delay = 5
			input_timer = 0
			enemy_name = "dark_z"
			player_turn = true
			turn_timer = 0
			message = ""
			inv = false
			lvl = 1
			menu = true
			mag = false
			max_hp = 10
			max_sp = 30
			on_guard = false
			cmenu = false
			char = "makoto"
			player_weak = "pierce"
			player_resist = "fire"
			melee = "slash"
			player_sp = 30
			enemies_defeated = 0
			enemy_power = 2
			enemy_type = "dark"
			enemy_weak = "light"
			player_hp = 10		
			title = true
	end
  -- turn delay countdown
  if turn_timer > 0 then
    turn_timer -= 1
    if turn_timer == 0 and not player_turn and not on_guard then
      -- enemy attacks after delay
     if player_weak == enemy_type then
     	player_hp -= enemy_power*2
      message = "enemy was super effective!"
      player_turn = true
     elseif player_resist == enemy_type then
      player_hp -= enemy_power/2
      message = "enemy wasn't effective."
      player_turn = true
      turn_timer = 30 -- show message briefly
					else
						player_hp -= enemy_power
      message = "enemy attacked!"
      player_turn = true
					end				
				elseif turn_timer == 0 and not player_turn and on_guard then
					if player_weak == enemy_type then				
						player_hp -=  enemy_power
						message = "enemy attacked! nice guard!"
						player_turn = true
						on_guard = false
						turn_timer = 30
					elseif player_resist == enemy_type then
						message = "enemy blocked!"
						player_turn = true
						turn_timer = 30
						on_guard = false   
   		else
   			player_hp -=  enemy_power/2
						message = "enemy attacked!"
						player_turn = true
						turn_timer = 30
						on_guard = false
  			end 
    end
    return
  end

  -- input delay
  if input_timer > 0 then
    input_timer -= 1
    return
  end

  -- movement
  if btn(3) then
    ypos += 10
    input_timer = input_delay
  elseif btn(2) then
    ypos -= 10
    input_timer = input_delay
  end

  _stay()
  _battle()
end

function _draw_game()
  cls()
  spr(2, xpos, ypos)
		if char == "makoto" then 
  sspr(88, 0, 8, 8, 15, 30, 16, 16)
		elseif char == "takeba" then
			sspr(96, 0, 8, 8, 15, 30, 16, 16) 
		elseif char == "kotone" then
			sspr(104, 0, 8, 8, 15, 30, 16, 16)
		elseif char == "koromaru" then
			sspr(112, 0, 8, 8, 15, 30, 16, 16)
		end 
  if enemy_name == "dark_z" then
  	sspr(32, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x
  elseif enemy_name == "fakefoot" then
			sspr(40, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x
 
  elseif enemy_name == "a from bn" then
  	sspr(48, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x

  elseif enemy_name == "lance" then
  	sspr(56, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x

  elseif enemy_name == "choco" then
  	sspr(64, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x

  elseif enemy_name == "pancake" then
  	sspr(72, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x

  elseif enemy_name == "ash" then
  	sspr(80, 0, 8, 8, 75, 30, 16, 16) -- draw sprite 4 scaled 2x
	
  end 

  -- menu options
  print("melee", 15, 70, 7)
  print("magic", 15, 80, 7)
  print("item", 15, 90, 7)
  print("guard", 15, 100, 7)

  if inv then
    print("scanner", 45, 70)
    print("swapper", 45, 80)
  end

  if mag then
    if char == "makoto" then
      print("fire i - 3 sp", 45, 70)
				elseif char == "takeba" then
					print("heal i - 4 sp",45,70)
					print("rest i - 4 hp",45,80)
				elseif char == "kotone" then
					print("light i - 3 sp",45,70)
				elseif char == "koromaru" then
					print("dark i - 3 sp",45,70)        
    end
  end

  if cmenu then
    if char == "makoto" then
      print("takeba", 45, 70)
      print("kotone", 45, 80)
      print("koromaru", 45, 90)
   	elseif char == "takeba" then
   		print("makoto", 45, 70)
     print("kotone", 45, 80)
     print("koromaru", 45, 90)
    elseif char == "kotone" then
    	print("makoto",45,70)
    	print("takeba",45,80)
    	print("koromaru",45,90)
    elseif char == "koromaru" then
   		print("makoto", 45, 70)
     print("takeba", 45, 80)
     print("kotone", 45, 90) 
    end
  end

  -- info and status
  print("enemy hp: "..enemy_hp, 75, 0)
  print("player hp: "..player_hp, 0, 0)
  print("player sp: "..player_sp, 0, 10)
		print("level: "..lvl, 0, 20)
  _info()

  -- action message
  print(message, 0, 110, 10)
end

function _info()
  if ypos == 70 and xpos == 5 then
    print("attack with your weapon", 5, 120, 7)
  elseif ypos == 80 and xpos == 5 then
    print("use magic in exchange for sp", 5, 120, 7)
  elseif ypos == 90 and xpos == 5 then
    print("use an item in your inventory", 5, 120, 7)
  elseif ypos == 100 and xpos == 5 then
    print("protect yourself partially", 5, 120, 7)
  elseif ypos == 70 and xpos == 37 and inv then
    print("find the enemy's weakness", 5, 120)
  elseif ypos == 80 and xpos == 37 and inv then
    print("swap out to another team member", 5, 120)
  elseif ypos == 70 and xpos == 37 and mag and char == "makoto" then
    print("light fire damage", 5, 120)
  elseif ypos == 70 and xpos == 37 and mag and char == "takeba" then
  	print("small hp heal",5,120)
  elseif ypos == 80 and xpos == 37 and mag and char == "takeba" then
  	print("small sp gain",5,120)  
		elseif ypos == 70 and xpos == 37 and cmenu == true and char == "makoto" then
			print("healing magic, piercing melee",5,120) 
		elseif ypos == 80 and xpos == 37 and cmenu == true and char == "makoto" then
			print("light magic, stabbing melee",5,120)
		elseif ypos == 90 and xpos == 37 and cmenu == true and char == "makoto" then
			print("dark magic, striking melee",5,120)
			 
  end
end

function _stay()
  if ypos > 100 then
    ypos = 70
  elseif ypos < 70 then
    ypos = 100
  end
end

function _battle()
  if not player_turn then return end

  -- main menu (melee, magic, item, guard)
  if menu and btnp(4) then
    if ypos == 70 then -- melee
     if char == "makoto" then
     	if melee == enemy_weak then
     	 enemy_hp -= 4
     	 message = "melee super effective!"
     	 player_turn = true
     	 turn_timer = 30
     	 input_timer = input_delay
   			elseif melee == enemy_type then
   				enemy_hp -= 1
   				message = "melee not effective."
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			else
   				enemy_hp -= 2
   				message = "you dealt 2 damage!"
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			end
   		elseif char == "takeba" then
   			if melee == enemy_weak then
     	 enemy_hp -= 2
     	 message = "melee super effective!"
     	 player_turn = true
     	 turn_timer = 30
     	 input_timer = input_delay
   			elseif melee == enemy_type then
   				message = "melee blocked!"
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			else
   				enemy_hp -= 1
   				message = "you dealt 1 damage!"
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			end
   		elseif char == "kotone" then
   			if melee == enemy_weak then
     	 enemy_hp -= 4
     	 message = "melee super effective!"
     	 player_turn = true
     	 turn_timer = 30
     	 input_timer = input_delay
   			elseif melee == enemy_type then
   				enemy_hp -= 1
   				message = "melee not effective."
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			else
   				enemy_hp -= 2
   				message = "you dealt 2 damage!"
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			end
   		elseif char == "koromaru" then
   			if melee == enemy_weak then
     	 enemy_hp -= 6
     	 message = "melee super effective!"
     	 player_turn = true
     	 turn_timer = 30
     	 input_timer = input_delay
   			elseif melee == enemy_type then
   				enemy_hp -= 2
   				message = "melee not effective."
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			else
   				enemy_hp -= 3
   				message = "you dealt 3 damage!"
   				player_turn = false
   				turn_timer = 30
   				input_timer = input_delay
   			end
   		end
    elseif ypos == 80 then -- magic menu
      mag = true
      menu = false
      xpos = 37
      ypos = 70
      input_timer = input_delay
    elseif ypos == 90 then -- inventory
      inv = true
      menu = false
      xpos = 37
      ypos = 70
      input_timer = input_delay
    elseif ypos == 100 then -- guard
      message = "you brace yourself!"
      on_guard = true
      player_turn = false
      turn_timer = 30
      input_timer = input_delay
    end

  -- magic submenu
  elseif mag then
    if btnp(4) and ypos == 70 then
      if char == "makoto" and player_sp >= 3 then
       if enemy_weak == "fire" then
       	enemy_hp -= 4
        message = "fire i was super effective!"
        player_sp -= 3
        player_turn = true
        turn_timer = 30	
       elseif enemy_type == "fire" then
       	enemy_hp -= 1
        message = "fire i wasn't effective."
        player_sp -= 3
        player_turn = false
        turn_timer = 30
       else
        enemy_hp -= 2
        message = "you use fire i! it did 2 damage!"
        player_sp -= 3
        player_turn = false
        turn_timer = 30
       end 
    	 elseif char == "koromaru" and player_sp >= 3 then
       if enemy_weak == "dark" then
       	enemy_hp -= 4
        message = "dark i was super effective!"
        player_sp -= 3
        player_turn = true
        turn_timer = 30	
       elseif enemy_type == "dark" then
       	enemy_hp -= 1
        message = "dark i wasn't effective."
        player_sp -= 3
        player_turn = false
        turn_timer = 30
       else
        enemy_hp -= 2
        message = "you use dark i! it did 2 damage!"
        player_sp -= 3
        player_turn = false
        turn_timer = 30
       end 
      elseif char == "kotone" and player_sp >= 3 then
       if enemy_weak == "light" then
       	enemy_hp -= 4
        message = "light i was super effective!"
        player_sp -= 3
        player_turn = true
        turn_timer = 30	
       elseif enemy_type == "light" then
       	enemy_hp -= 1
        message = "light i wasn't effective."
        player_sp -= 3
        player_turn = false
        turn_timer = 30
       else
        enemy_hp -= 2
        message = "you use light i! it did 2 damage!"
        player_sp -= 3
        player_turn = false
        turn_timer = 30
       end
      end
    elseif btnp(4) and ypos == 80 then
      if char == "takeba" and player_hp >= 4 and max_sp - player_sp >= 5 then
        player_sp += 5
        message = "you healed 5 sp!"
        player_hp -= 4
        player_turn = false
        turn_timer = 30
     	elseif char == "takeba" and player_hp >= 4 and max_sp - player_sp < 5 then
     			player_sp = max_sp
        message = "you healed to full sp!"
        player_hp -= 4
        player_turn = false
        turn_timer = 30  
      end	
    elseif btnp(5) then
      mag = false
      menu = true
      xpos = 5
      ypos = 80
      message = ""
    end

  -- inventory submenu
  elseif inv then
    if btnp(4) then
      if ypos == 70 then
        message = "the enemy is weak to "..enemy_weak.."!"
        menu = true
        inv = false
        xpos = 5
        ypos = 80
        player_turn = false
        turn_timer = 30
      elseif ypos == 80 then
        cmenu = true
        inv = false
        menu = false
        xpos = 37
        ypos = 70
      end
    elseif btnp(5) then
      inv = false
      menu = true
      xpos = 5
      ypos = 90
      message = ""
    end

  -- character swap menu
  elseif cmenu then
    if btnp(4) then
    	if char == "makoto" then
      if ypos == 70 then
        message = "swapped to takeba."
        char = "takeba"
        player_weak = "stab"
								player_resist = ""
								melee = "pierce"
      elseif ypos == 80 then
        message = "swapped to kotone."
        char = "kotone"
        player_weak = "dark"
        player_resist = "light"
        melee = "stab"
      elseif ypos == 90 then
        message = "swapped to koromaru."
        char = "koromaru"
        player_weak = "slash"
        player_resist = "strike"
  						melee = "strike"   
      end
     elseif char == "takeba" then
      if ypos == 70 then
        message = "swapped to makoto."
        char = "makoto"
        player_weak = "pierce"
        player_resist = "fire"
        melee = "slash"
      elseif ypos == 80 then
        message = "swapped to kotone."
        char = "kotone"
        player_weak = "dark"
        player_resist = "light"
        melee = "stab"
      elseif ypos == 90 then
        message = "swapped to koromaru."
        char = "koromaru"
        player_weak = "slash"
        player_resist = "strike"
        melee = "strike"
      end
     elseif char == "kotone" then
      if ypos == 70 then
        message = "swapped to makoto."
        char = "makoto"
        player_weak = "pierce"
        player_resist = "fire"
        melee = "slash"
      elseif ypos == 80 then
        message = "swapped to takeba."
        char = "takeba"
        player_weak = "stab"
        player_resist = ""
        melee = "pierce"
      elseif ypos == 90 then
        message = "swapped to koromaru."
        char = "koromaru"
        player_weak = "slash"
        player_resist = "strike"
        melee = "strike"
      end
     elseif char == "koromaru" then
      if ypos == 70 then
        message = "swapped to makoto."
        char = "makoto"
        player_weak = "pierce"
        player_resist = "fire"
        melee = "slash"
      elseif ypos == 80 then
        message = "swapped to takeba."
        char = "takeba"
        player_weak = "stab"
        player_resist = ""
        melee = "pierce"
      elseif ypos == 90 then
        message = "swapped to kotone."
        char = "kotone"
        player_weak = "dark"
        player_resist = "light"
        melee = "stab"
      end
     end
      cmenu = false
      menu = true
      xpos = 5
      ypos = 70
      player_turn = false
      turn_timer = 30
    elseif btnp(5) then
      cmenu = false
      menu = true
      xpos = 5
      ypos = 80
      message = ""
    end
  end

  -- enemy defeated check
  if enemy_hp <= 0 then
   if enemies_defeated % 5 ~= 0 then
    enemy_hp = 0
    message = "you win! +10xp. enemy inc!"
    enemies_defeated += 1
   elseif	enemies_defeated % 5 == 0 then
   	enemy_hp = 0
   	message = "lvl up! +5 stats. enemy inc!"
   	enemies_defeated += 1
   	lvl += 1
   	max_hp += 5
   	max_sp += 5
   	player_hp = max_hp
   	player_sp = max_sp
   end

			  

    -- enemy selection
    e = flr(rnd(7)) + 1
    t = flr(rnd(7)) + 1
    w = flr(rnd(7)) + 1

    -- base scaling
    enemy_hp = enemies_defeated * 2 + 3
    enemy_power = enemies_defeated * 1.5 + 2
				if max_hp - player_hp <= 2 then
					player_hp += 2
				else 
					player_hp = max_hp
				end
    -- name/stats
    if e == 1 then
      enemy_name = "dark_z"
      enemy_hp -= 1
      enemy_power += 1
    elseif e == 2 then
      enemy_name = "fakefoot"
      enemy_hp += 1
      enemy_power -= 1
    elseif e == 3 then
      enemy_name = "a from bn"
      enemy_hp -= 1
      enemy_power -= 1
    elseif e == 4 then
      enemy_name = "lance"
      enemy_hp += 1
      enemy_power += 1
    elseif e == 5 then
      enemy_name = "choco"
      enemy_hp -= 3
      enemy_power += 2
    elseif e == 6 then
      enemy_name = "pancake"
      enemy_hp += 3
      enemy_power -= 2
    elseif e == 7 then
      enemy_name = "ash"
      enemy_hp -= 2
      enemy_power += 3
    end

    -- type and weakness
    types = {"slash", "pierce", "stab", "strike", "fire", "light", "dark"}
    enemy_type = types[t]
    enemy_weak = types[w]
    if enemy_type == enemy_weak then
 			 enemy_type = types[(t % #types) + 1]
				end


    -- next turn
    player_turn = true
  end
end





__gfx__
000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000ccccc000044400088888800007707700000000
00000000000000000000a00000000000000c00000000000000000000200000020000000000000000098a890000f0ccc000404000080f08800007060700000000
0070070000000000000aa00000000000c0cccc0c0009900000000110202222020644446000044400008a800000fffff004ffff400fffff800000666000000000
000770000000000000aaa000000000000cccccc00009990000011110222222220644446000444440005550000111111000eeee00222222200686866000000000
000770000000000000aa00000000000000cccc00009999000011111000222200006666000044a44005555500111111110e0ee0e0202220200686860000000000
007007000000000000a000000000000000c0c00009999900088811000002200000666600004444400555550000111100f00ee00ff01010f00060060000000000
000000000000000000000000000000000cc0cc000999900099880000022222200066660000044400555555500020020000ecce00001010000060060000000000
0000000000000000000000000000000000000000000990000990000000000000000000000000000000000000022002200cc00cc0011011000060060000000000
__sfx__
00010000120500a050210502305025050260502005028050180501c0502005005050230500a05024050100501f050220501a050200500c0502505006050270501d0501a050180501705016050170501905000000
001000000c0500c0500c05506000000000000026000030002a0000000000000050000000031000000000000012000310000000000000070000000000000000000c0500c0500c0550000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000100001f05000000000000000000000000000b05000000000000000000000000002a05000000060500505000000000000000000000270500000000000000000a050000000000022050000000505000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000c05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344

