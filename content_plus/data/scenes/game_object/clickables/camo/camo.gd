extends Clickable
@onready var timer: Timer = $Timer


func double_click_action() -> void :
	GameEvents.folder_double_clicked.emit()
	GameEvents.emit_objective_file_opened("camo")

	StatsManager.add_timed_buff("upgrade_player_dodge", 100.0, 5.0, StatsManager.ModifierType.FLAT)
	StatsManager.add_timed_buff("upgrade_player_speed", 1.5, 5.0, StatsManager.ModifierType.FLAT)
	GameEvents.reset_weapons()
	timer.wait_time = 5.0
	timer.start()

	in_use()


func _on_timer_timeout() -> void :
	queue_free()
