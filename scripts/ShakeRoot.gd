extends Area

export var shake_intensity := 0.1

func shake_cam():
	var shaking_area := get_overlapping_areas()
	for area in shaking_area:
		if area.has_method("_increase_shake"):
			area._increase_shake(shake_intensity)
