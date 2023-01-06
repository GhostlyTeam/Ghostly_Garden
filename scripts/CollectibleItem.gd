extends Area

export(String, "GoldBar", "Ruby", "Pearl") var item_type 
class_name CollectibleItem

func _ready():
	
	$Gold.visible = false
	$Pearl.visible = false
	$Ruby.visible = false
	
	if item_type == "GoldBar":
		$Gold.visible = true
	elif item_type == "Ruby":
		$Ruby.visible = true
	elif item_type == "Pearl":
		$Pearl.visible = true

func get_collectible_type():
	return item_type
	

func get_class():
	return "CollectibleItem"
