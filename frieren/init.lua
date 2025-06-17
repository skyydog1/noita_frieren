function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created

	local selected_char = ModSettingGet("frieren.char")
	selected_char = string.lower(selected_char):gsub("^%s+", ""):gsub("%s+$", "")

	GamePrint("playing as " .. (selected_char))

	-- Frieren logic
	if selected_char == "frieren" then
		GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )

		ComponentSetValue2( EntityGetFirstComponent( player_entity, "SpriteComponent" ), "image_file", "mods/frieren/files/skin_frieren/enemies_gfx/player_hat_m.xml" )

		local plyrChildEnt = EntityGetAllChildren( player_entity )
				if ( plyrChildEnt ~= nil ) then
					for i,chldEntity in ipairs( plyrChildEnt ) do
						local childName = EntityGetName( chldEntity )
						if ( childName == "arm_r" ) then
							EntityKill( chldEntity )
							arm_entity = EntityLoad( "mods/frieren/files/skin_frieren/entities/player_arm.xml")
							EntityAddChild( player_entity, arm_entity )
							break
						end
					end
				end

		EntityAddComponent( player_entity, "SpriteComponent",
			{
				_tags="character, Frieren_Hat, hat_fix1",
				alpha="1", 
				image_file="mods/frieren/files/skin_frieren/enemies_gfx/player_head.xml", 
				next_rect_animation="", 
				offset_x="6", 
				offset_y="14" ,
				rect_animation="walk",
				update_transform="1",                                               
				z_index="0.602"
			} )

		EntityAddComponent( player_entity, "SpriteComponent",
			{
				_tags="character, Frieren_Hat, hat_fix2",
				alpha="0", 
				image_file="mods/frieren/files/skin_frieren/enemies_gfx/player_head2.xml", 
				next_rect_animation="", 
				offset_x="6", 
				offset_y="14" ,
				rect_animation="walk",
				update_transform="1",                                               
				z_index="0.602"
			} )		

		ComponentSetValue2( EntityGetFirstComponent( player_entity, "DamageModelComponent" ), "ragdoll_filenames_file", "mods/frieren/files/skin_frieren/ragdolls/player/filenames.txt" )

		-- Adds new hotspots
		EntityAddComponent( player_entity, "HotspotComponent",
			{
				_tags="bangs_root",
				sprite_hotspot_name="bangs"	
			} )

		-- Adds new verlet chain entities
		local px, py = EntityGetTransform( player_entity )
		local ent_bang1 = EntityLoad("mods/frieren/files/skin_frieren/entities/verlet_chains/frieren_bangs/verlet_bang1.xml",px, py)
		local ent_bang2 = EntityLoad("mods/frieren/files/skin_frieren/entities/verlet_chains/frieren_bangs/verlet_bang2.xml",px, py)
		local ent_bangC = EntityLoad("mods/frieren/files/skin_frieren/entities/verlet_chains/frieren_bangs/verlet_bangC.xml",px, py)
		local ent_bangL = EntityLoad("mods/frieren/files/skin_frieren/entities/verlet_chains/frieren_bangs/verlet_bangL.xml",px, py)
		local ent_bangR = EntityLoad("mods/frieren/files/skin_frieren/entities/verlet_chains/frieren_bangs/verlet_bangR.xml",px, py)

		EntityAddChild(player_entity, ent_bang1 )
		EntityAddChild(player_entity, ent_bang2 )
		EntityAddChild(player_entity, ent_bangC )	
		EntityAddChild(player_entity, ent_bangL )
		EntityAddChild(player_entity, ent_bangR )

		-- Kills the cape
		local plyChildEnt = EntityGetAllChildren( player_entity )
		if ( plyChildEnt ~= nil ) then
			for i,childEntity in ipairs( plyChildEnt ) do
				if ( EntityGetName( childEntity ) == "cape" ) then
					EntityKill( childEntity ) 
					break
				end
			end
		end

	--Fern logic
	elseif selected_char == "fern" then
		GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )

		ComponentSetValue2( EntityGetFirstComponent( player_entity, "SpriteComponent" ), "image_file", "mods/frieren/files/skin_fern/enemies_gfx/player_hat_m.xml" )

		local plyrChildEnt = EntityGetAllChildren( player_entity )
				if ( plyrChildEnt ~= nil ) then
					for i,chldEntity in ipairs( plyrChildEnt ) do
						local childName = EntityGetName( chldEntity )
						if ( childName == "arm_r" ) then
							EntityKill( chldEntity )
							arm_entity = EntityLoad( "mods/frieren/files/skin_fern/entities/player_arm.xml")
							EntityAddChild( player_entity, arm_entity )
							break
						end
					end
				end

		EntityAddComponent( player_entity, "SpriteComponent",
			{
				_tags="character, Frieren_Hat, hat_fix1",
				alpha="1", 
				image_file="mods/frieren/files/skin_fern/enemies_gfx/player_head.xml", 
				next_rect_animation="", 
				offset_x="6", 
				offset_y="14" ,
				rect_animation="walk",
				update_transform="1",                                               
				z_index="0.602"
			} )

		EntityAddComponent( player_entity, "SpriteComponent",
			{
				_tags="character, Frieren_Hat, hat_fix2",
				alpha="0", 
				image_file="mods/frieren/files/skin_fern/enemies_gfx/player_head2.xml", 
				next_rect_animation="", 
				offset_x="6", 
				offset_y="14" ,
				rect_animation="walk",
				update_transform="1",                                               
				z_index="0.602"
			} )		

		ComponentSetValue2( EntityGetFirstComponent( player_entity, "DamageModelComponent" ), "ragdoll_filenames_file", "mods/frieren/files/skin_fern/ragdolls/player/filenames.txt" )

		-- Adds new hotspots
		EntityAddComponent( player_entity, "HotspotComponent",
			{
				_tags="bangs_root",
				sprite_hotspot_name="bangs"	
			} )

		-- Adds new verlet chain entities
		local px, py = EntityGetTransform( player_entity )
		local ent_bang1 = EntityLoad("mods/frieren/files/skin_fern/entities/verlet_chains/frieren_bangs/verlet_bang1.xml",px, py)
		local ent_bang2 = EntityLoad("mods/frieren/files/skin_fern/entities/verlet_chains/frieren_bangs/verlet_bang2.xml",px, py)
		local ent_bangC = EntityLoad("mods/frieren/files/skin_fern/entities/verlet_chains/frieren_bangs/verlet_bangC.xml",px, py)
		local ent_bangL = EntityLoad("mods/frieren/files/skin_fern/entities/verlet_chains/frieren_bangs/verlet_bangL.xml",px, py)
		local ent_bangR = EntityLoad("mods/frieren/files/skin_fern/entities/verlet_chains/frieren_bangs/verlet_bangR.xml",px, py)

		EntityAddChild(player_entity, ent_bang1 )
		EntityAddChild(player_entity, ent_bang2 )
		EntityAddChild(player_entity, ent_bangC )	
		EntityAddChild(player_entity, ent_bangL )
		EntityAddChild(player_entity, ent_bangR )

		-- Kills the cape
		local plyChildEnt = EntityGetAllChildren( player_entity )
		if ( plyChildEnt ~= nil ) then
			for i,childEntity in ipairs( plyChildEnt ) do
				if ( EntityGetName( childEntity ) == "cape" ) then
					EntityKill( childEntity ) 
					break
				end
			end
		end
	end
	-- These are for adding death/invis fixes when I get around to it

	-- EntityAddComponent( player_entity, "LuaComponent",
	-- {
	-- 	remove_after_executed="0",
	-- 	execute_times="-1",
	-- 	script_source_file="data/scripts/invisibility_fix.lua"
	-- } )
	-- EntityAddComponent( player_entity, "LuaComponent",
	-- {
	-- 	remove_after_executed="0",
	-- 	execute_times="-1",
	-- 	script_source_file="data/scripts/frieren_no_mana_timer.lua"
	-- } )


end


dofile_once( "data/scripts/lib/utilities.lua" )

-- all functions below are optional and can be left out

--[[

function OnModPreInit()
	print("Mod - OnModPreInit()") -- First this is called for all mods
end

function OnModInit()
	print("Mod - OnModInit()") -- After that this is called for all mods
end

function OnModPostInit()
	print("Mod - OnModPostInit()") -- Then this is called for all mods
end

function OnWorldPreUpdate() -- This is called every time the game is about to start updating the world
	GamePrint( "Pre-update hook " .. tostring(GameGetFrameNum()) )
end

function OnWorldPostUpdate() -- This is called every time the game has finished updating the world
	GamePrint( "Post-update hook " .. tostring(GameGetFrameNum()) )
end

]]--

function OnMagicNumbersAndWorldSeedInitialized() -- this is the last point where the Mod* API is available. after this materials.xml will be loaded.
	local x = ProceduralRandom(0,0)
	print( "===================================== random " .. tostring(x) )
end


-- This code runs when all mods' filesystems are registered
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/example/files/actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua
ModMagicNumbersFileAdd( "mods/example/files/magic_numbers.xml" ) -- Will override some magic numbers using the specified file

-- see tools_modding/noita_fmod_project/ for the project that defines the audio events used in this mod
ModRegisterAudioEventMappings( "mods/example/files/audio_events.txt" ) -- Use this to register custom fmod events. Event mapping files can be generated via File -> Export GUIDs in FMOD Studio.
ModRegisterMusicBank( "mods/example/files/music.bank" ) -- Use this to register custom banks in the music system. ModRegisterAudioEventMappings also needs to be called to make the game recognize the events.