extends PanelContainer
class_name UpgradeOption

@export var upgrade_res : Upgrade

@onready var texture_rect: TextureRect = %TextureRect
@onready var item_name: RichTextLabel = %ItemName

func _ready() -> void:
	item_name.text = "[center]" + upgrade_res.upgrd_name
	texture_rect.texture = upgrade_res.icon

func _on_take_button_pressed() -> void:
	SignalBus.emit_signal("upgrade_get", upgrade_res)
	SignalBus.emit_signal("round_start")
