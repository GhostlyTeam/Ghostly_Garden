extends Area

export(String, "GoldBar", "Ruby", "Pearl") var item_type 
class_name CollectibleItem


func get_collectible_type():
	return item_type
	
func get_class():
	return "CollectibleItem"
