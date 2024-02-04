extends Control

class_name UI

@onready var score_text : RichTextLabel = $Score
@onready var timer_text : RichTextLabel = $Timer

@onready var score_format : String = score_text.text
@onready var timer_format : String = timer_text.text

func set_score(score: int):
	score_text.text = score_format % score

func set_timer(timer: int):
	@warning_ignore("integer_division")
	var minutes: int = timer / 60
	var seconds: int = timer % 60
	timer_text.text = timer_format % [minutes, seconds]
	pass
