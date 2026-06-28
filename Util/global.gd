extends Node


func insert_group_splitters(value:String, splitter:String = ".", group_size:int = 3):
	
	var temp = value
	
	value = temp.left(temp.length()%group_size)
	temp = temp.trim_prefix(value)
	
	for i in temp.length()/group_size:
		value += splitter
		
		value += temp.left(group_size)
		temp = temp.trim_prefix(temp.left(group_size))
	
	value = value.trim_prefix(splitter)
	return value
