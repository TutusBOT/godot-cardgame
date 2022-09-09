extends Control

const CONFIG_FILE = "user://config_file.cfg"
var config = ConfigFile.new()

func _ready() -> void:
	var err = config.load(CONFIG_FILE)
	print(err)
	if err != OK:
		return
	$SettingsList/FullscreenContainer/Fullscreen.pressed = config.get_value("Config", "fullscreen")

func _on_TextureButton_pressed() -> void:
	$SettingsList.visible = !$SettingsList.visible


func _on_Fullscreen_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed
	config.set_value("Config", "fullscreen", button_pressed)
	config.save(CONFIG_FILE)
