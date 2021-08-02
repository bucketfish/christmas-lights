extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var line = {
	"":[],

	"silver_intro":[
		["s", "SILVER_INTRO_1", "NAME_SILVER"],
		["s", "SILVER_INTRO_2", "NAME_SILVER"],
		["s", "SILVER_INTRO_2a", "NAME_RAIN"],
		["s","SILVER_INTRO_3", "NAME_SILVER"],
		["s","SILVER_INTRO_4", "NAME_SILVER"],
		["s","SILVER_INTRO_4a", "NAME_RAIN"],
		["s","SILVER_INTRO_5", "NAME_SILVER"],
		["s","SILVER_INTRO_6", "NAME_SILVER"],
		["a", "get_item", "berry", 5],
		["e", "silver_give1"]
	],
	"silver_intro_repeat1":[
		["s", "SILVER_INTRO_REPEAT1_1", "NAME_SILVER"],
		["a", "get_notebook", "doodle2_3"]
	],
	"silver_intro_repeat2":[
		["s", "SILVER_INTRO_REPEAT2_1", "NAME_SILVER"]
	],
	
	'berrymover1':[
		["c", "insert_berry", 15, "berrymover1_accept", ""]
	],
	"berrymover1_accept":[
		["a", "get_item", "berry", -15],
		["a", "get_notebook", "doodle3_2"]
	],
}
