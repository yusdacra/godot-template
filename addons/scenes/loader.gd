extends RefCounted


signal resource_loaded(res)
signal resource_stage_loaded(progress_percentage)


func load_resource(path):
	if ResourceLoader.has_cached(path): return ResourceLoader.load(path)
	else: _thread_load(path)


func _thread_load(path):
	var status = ResourceLoader.load_threaded_request(path)
	if status != OK:
		push_error(status, "loader failed")
		return
	var res = null
	var progress_arr = []

	while true:
		var loading_status = ResourceLoader.load_threaded_get_status(path, progress_arr)
		if loading_status == ResourceLoader.THREAD_LOAD_LOADED:
			call_deferred("emit_signal", "resource_stage_loaded", float(progress_arr[0]))
			res = ResourceLoader.load_threaded_get(path)
			break
		elif loading_status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Loader failed for: {0}".format([path]))
			break
		elif loading_status == ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			push_error("Loader invalid resource: {0}".format([path]))
		else:
			call_deferred("emit_signal", "resource_stage_loaded", float(progress_arr[0]))
			pass
	
	call_deferred("_thread_done", res)


func _thread_done(resource):
	assert(resource)
	resource_loaded.emit(resource)
