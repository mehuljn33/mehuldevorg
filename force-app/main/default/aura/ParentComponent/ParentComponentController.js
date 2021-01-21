({
	handleEvent : function(component, event, helper) {
		var param = event.getParams('parameter1');
        var str = param.toString();
        alert('hi' + str);
	}
})