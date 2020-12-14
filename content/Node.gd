extends Control

var player_words = []
var last_input = ""
			
var template = [{
		"prompts":["Time", "Food", "Event", "Person"],
		"story":"%s I ate too much %s"+\
			" and felt sick. So I couldn't attend "+\
			"%s, that was organized in memory of %s"
		},
		{
		"prompts":["Name", "Adjective", "Noun", "verb", "Adjective"],
		"story":"%s was very %s" +\
			" and saw %s. I couldn't "+\
			"%s him, and it was very %s"
		},
		]
		
var current_story

func pick_story():
	current_story = template[randi()%2]

func _ready():
	
	pick_story()
	$DisplayText.text = "Welcome to Loony Lips"
	$PlayerText.grab_focus()
#
#	var prompts = ["Long time ago", 
#					"Jann", 
#					"Conan", 
#					"greatest", 
#					"the decade"]
#
#	var story = "%s %s watched %s"+\
#		" and thought it was the %s movie of %s"
#
#	$DisplayText.text = story % prompts


func _on_PlayerText_text_entered(new_text):
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		get_input($PlayerText.text)
	
func _on_SubmitText_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		get_input($PlayerText.text)
	
func get_input(input):
	last_input = input
	$PlayerText.clear()
	append_player_words(input)
	if is_story_done():
		tell_story()
	else:
		prompt_player()
	
func append_player_words(word):
	player_words.append(word)
	
func is_story_done():
	return player_words.size() == current_story["prompts"].size()
	
func tell_story():
	$DisplayText.text = current_story["story"] % player_words
	endgame()
	
func prompt_player():
	var prompt = "Please give me: "+current_story["prompts"][player_words.size()]
	$DisplayText.text = prompt


func _on_PlayerText_text_changed(new_text):
	if not is_story_done():
		prompt_player()
	
func endgame():
	$PlayerText.text = "Again?"
