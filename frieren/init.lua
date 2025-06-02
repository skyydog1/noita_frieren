function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )

	ComponentSetValue2( EntityGetFirstComponent( player_entity, "SpriteComponent" ), "image_file", "mods/frieren/files/skin/enemies_gfx/player_hat_m.xml" )

	local plyrChildEnt = EntityGetAllChildren( player_entity )
			if ( plyrChildEnt ~= nil ) then
				for i,chldEntity in ipairs( plyrChildEnt ) do
					local childName = EntityGetName( chldEntity )
					if ( childName == "arm_r" ) then
						EntityKill( chldEntity )
						arm_entity = EntityLoad( "mods/frieren/files/skin/entities/player_arm.xml")
						EntityAddChild( player_entity, arm_entity )
						break
					end
				end
			end

	EntityAddComponent( player_entity, "SpriteComponent",
		{
			_tags="character, Frieren_Hat, hat_fix1",
			alpha="1", 
			image_file="mods/frieren/files/skin/enemies_gfx/player_head.xml", 
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
			image_file="mods/frieren/files/skin/enemies_gfx/player_head2.xml", 
			next_rect_animation="", 
			offset_x="6", 
			offset_y="14" ,
			rect_animation="walk",
			update_transform="1",                                               
			z_index="0.602"
		} )		

	ComponentSetValue2( EntityGetFirstComponent( player_entity, "DamageModelComponent" ), "ragdoll_filenames_file", "mods/frieren/files/skin/ragdolls/player/filenames.txt" )

	-- Adds new hotspots
	EntityAddComponent( player_entity, "HotspotComponent",
		{
			_tags="bangs_root",
			sprite_hotspot_name="bangs"	
		} )

	-- Adds new verlet chain entities
	local px, py = EntityGetTransform( player_entity )
	local ent_bang1 = EntityLoad("mods/frieren/files/skin/entities/verlet_chains/frieren_bangs/verlet_bang1.xml",px, py)
	local ent_bang2 = EntityLoad("mods/frieren/files/skin/entities/verlet_chains/frieren_bangs/verlet_bang2.xml",px, py)
	local ent_bangC = EntityLoad("mods/frieren/files/skin/entities/verlet_chains/frieren_bangs/verlet_bangC.xml",px, py)
	local ent_bangL = EntityLoad("mods/frieren/files/skin/entities/verlet_chains/frieren_bangs/verlet_bangL.xml",px, py)
	local ent_bangR = EntityLoad("mods/frieren/files/skin/entities/verlet_chains/frieren_bangs/verlet_bangR.xml",px, py)

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

function OnPlayerSpawned( player_entity ) -- This runs when player entity has been created
	GamePrint( "OnPlayerSpawned() - Player entity id: " .. tostring(player_entity) )
end

function OnWorldInitialized() -- This is called once the game world is initialized. Doesn't ensure any world chunks actually exist. Use OnPlayerSpawned to ensure the chunks around player have been loaded or created.
	GamePrint( "OnWorldInitialized() " .. tostring(GameGetFrameNum()) )
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

ModMaterialsFileAdd( "mods/example/files/materials_rainbow.xml" ) -- Adds a new 'rainbow' material to materials
ModLuaFileAppend( "data/scripts/items/potion.lua", "mods/example/files/potion_appends.lua" )

-- make coalmine play music from the new bank
local coal_xml = ModTextFileGetContent( "data/biome/coalmine.xml" )
coal_xml = coal_xml:gsub([[audio_music_2="coalmine"]], [[audio_music_2="thebiome"]] )
ModTextFileSetContent( "data/biome/coalmine.xml", coal_xml )


if ModImageMakeEditable ~= nil then -- needed to avoid error if this file is hotloaded after init
	-- make the player sprite green
	local t1 = GameGetRealWorldTimeSinceStarted();

	local recolor = function( filename)
		local id,w,h = ModImageMakeEditable( filename, 0, 0 )
		for y=0,h do 
			for x=0,w do
				local c = ModImageGetPixel( id, x, y )
				local r,g,b,a = color_abgr_split( c )
				r = r / 2
				b = b / 2
				c = color_abgr_merge(r,g,b,a)
				ModImageSetPixel( id, x, y, c )
			end
		end
	end

	-- using different slots here to test the feature works, 
	-- but you could use the same slot when editing images independent of each other like this
	recolor( "data/enemies_gfx/player.png" )
	recolor( "data/enemies_gfx/player_arm.png" )
	recolor( "data/enemies_gfx/player_arm_no_item.png" )

	t1 = GameGetRealWorldTimeSinceStarted() -t1
	print("ModImage stuff took " .. t1 .. " seconds")

	local who_edited = ModImageWhoSetContent( "data/enemies_gfx/player.png" )
	local ok = " - fail"
	if who_edited == "example" then ok = " - ok" end

	print( "Who edited? " .. who_edited .. ok )
end

--print("Example mod init done")