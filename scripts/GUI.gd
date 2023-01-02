extends MarginContainer

var gold_bar
var gold_bar_grayscale
var ruby
var ruby_grayscale
var pearl
var pearl_grayscale


func _ready():
	gold_bar = load("res://assets/gold-bar-small.png")
	gold_bar_grayscale = load("res://assets/gold-bar-small-grayscale.png")
	ruby = load("res://assets/ruby-small.png")
	ruby_grayscale = load("res://assets/ruby-small-grayscale.png")
	pearl = load("res://assets/pearl-small.png")
	pearl_grayscale = load("res://assets/pearl-small-grayscale.png")


func set_health(health):
	$HUD/Bars/Health.value = health
	
func set_flashlight(flashlight_value):
	$HUD/Bars/Flashlight.value = flashlight_value
	
func toggle_gold_bar(value):
	if value == true:
		$HUD/Items/GoldBar.modulate = Color("#ffffffff")
		$HUD/Items/GoldBar.texture = gold_bar
	else:
		$HUD/Items/GoldBar.modulate = Color("#64ffffff")
		$HUD/Items/GoldBar.texture = gold_bar_grayscale
	
func toggle_ruby(value):
	if value == true:
		$HUD/Items/Ruby.modulate = Color("#ffffffff")
		$HUD/Items/Ruby.texture = ruby
	else:
		$HUD/Items/Ruby.modulate = Color("#64ffffff")
		$HUD/Items/Ruby.texture = ruby_grayscale
		
func toggle_pearl(value):
	if value == true:
		$HUD/Items/Pearl.modulate = Color("#ffffffff")
		$HUD/Items/Pearl.texture = pearl
	else:
		$HUD/Items/Pearl.modulate = Color("#64ffffff")
		$HUD/Items/Pearl.texture = pearl_grayscale

