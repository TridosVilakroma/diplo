extends Node

var save_slot:String


func repair_save_tree():
	print('hghghghghghg')
	if not DirAccess.dir_exists_absolute("user://Saves"):
		DirAccess.make_dir_absolute("user://Saves")
	if not FileAccess.file_exists("user://Saves/file_1.save"):
		var _f=FileAccess.open("user://Saves/file_1.save", FileAccess.WRITE)
		_f.store_line("{}")
	if not FileAccess.file_exists("user://Saves/file_2.save"):
		var _f=FileAccess.open("user://Saves/file_2.save", FileAccess.WRITE)
		_f.store_line("{}")
	if not FileAccess.file_exists("user://Saves/file_3.save"):
		var _f=FileAccess.open("user://Saves/file_3.save", FileAccess.WRITE)
		_f.store_line("{}")


func save_slot_write(data:Dictionary):
	var save_file = FileAccess.open("user://Saves/%s.save" % save_slot, FileAccess.WRITE)
	save_file.store_line(JSON.stringify(data,"\t",false))


func save_slot_read()->Dictionary:
	var save_file = FileAccess.open("user://Saves/%s.save" % save_slot, FileAccess.READ)
	return JSON.parse_string(save_file.get_as_text())


func save_file_read(file:String)->Dictionary:
	var save_file = FileAccess.open("user://Saves/%s.save" % file, FileAccess.READ)
	return JSON.parse_string(save_file.get_as_text())


func gather_data()->Dictionary:
	#TODO add data to be saved:
	#     (multiplayer chars, known boss portals, and gold)
	var data:Dictionary={}
	#add data k,v pairs here
	return data


func save_game():
	if not save_slot:
		print('no save slot selected')
		return
	save_slot_write(gather_data())


func get_save_slots_view():
	repair_save_tree()
	var packed_data:={
		"file_1":save_file_read("file_1"),
		"file_2":save_file_read("file_2"),
		"file_3":save_file_read("file_3")
		}
	return packed_data


func decode_view(view:Dictionary):
	var data:String=""
	if not view:
		return "No Save Data\n\nStart A New Game!"
	if "gold" in view:
		if int(view.gold)>0:
			data+="Gold: "+ str(view.gold)+"\n"
	if "relics" in view:
		if len(view.relics)>0:
			data+="Relics: "+ str(len(view.relics))+"\n"
	if "weapons" in view:
		if len(view.weapons)>0:
			data+="Weapons: "+ str(len(view.weapons))+"\n"
		else:data+="Weapons: "+ str(1)+"\n"
	if "armors" in view:
		if len(view.armors)>0:
			data+="Armors: "+ str(len(view.armors))+"\n"
	if "tools" in view:
		if len(view.tools)>0:
			data+="Tools: "+ str(len(view.tools))+"\n"
	if "consumables" in view:
		if len(view.consumables)>0:
			data+="Consumables: "+ str(len(view.consumables))+"\n"
	if "portals" in view:
		if len(view.portals)>0:
			data+="Portals: "+ str(len(view.portals))
	return data


func delete_file(file:String):
	var dir_access=DirAccess.open("user://")
	dir_access.remove("Saves/file_%s.save" % file)
