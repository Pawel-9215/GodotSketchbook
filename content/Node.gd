extends Control

var player_words = []
var last_input = ""
var prompts = ["Time", "Food", "Event", "Person"]
var story = "%s I ate too much %s"+\
			"and felt sick. So I couldne attend"+\
			"%s, that was organized in memory of %s"

#func _ready():
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
	get_input(new_text)
	
func _on_SubmitText_pressed():
	get_input($PlayerText.text)
	
func get_input(input):
	last_input = input
	$PlayerText.clear()
	append_player_words(input)
	if is_story_done():
		tell_story()
	
func append_player_words(word):
	player_words.append(word)
	
func is_story_done():
	return player_words.size() == prompts.size()
	
func tell_story():
	$DisplayText.text = story % player_words
	
func prompt_player():
	var prompt = "May I have"
