extends Control

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_visual
@onready var labelText = $CenterContainer/Panel/item_visual/Label

func update(item: Collectable):
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture
		labelText.text = str(item.amount)
