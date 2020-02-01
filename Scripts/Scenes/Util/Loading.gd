extends Node

const CHARACTER: String = "character"
const BACKGROUND: String = "background"
const SFX: String = "sfx"
const BGM: String = "bgm"

var loaded_characters: bool = false
var loaded_backgrounds: bool = false
var loaded_sfx: bool = false
var loaded_bgm: bool = false

var game_scene = preload("res://Scenes/Game/Game.tscn")

func _ready():
	BackgroundManager.connect("loading_complete_s", self, "finish_loading", [BACKGROUND])
	CharacterManager.connect("loading_complete_s", self, "finish_loading", [CHARACTER])
	SFXManager.connect("loading_complete_s", self, "finish_loading", [SFX])
	BGMManager.connect("loading_complete_s", self, "finish_loading", [BGM])
	
	BackgroundManager.load_threaded()
	CharacterManager.load_threaded()
	SFXManager.load_threaded()
	BGMManager.load_threaded()

func switch_scene(scene: PackedScene):
	if scene:
		yield($Control/AnimatedSprite, "animation_finished")
		get_tree().change_scene_to(scene)

func finish_loading(key: String):
	match key:
		CHARACTER:
			loaded_characters = true
		BACKGROUND:
			loaded_backgrounds = true
		SFX:
			loaded_sfx = true
		BGM:
			loaded_bgm = true
	
	if loaded_characters and loaded_backgrounds and loaded_sfx and loaded_bgm:
		switch_scene(game_scene)
