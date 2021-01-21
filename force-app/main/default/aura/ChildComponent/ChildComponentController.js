({
	fireEvent : function(component, event, helper) {
		var compEvent = component.getEvent('ComponentEvent1');
        compEvent.setParams({
            parameter1 : 'Param from child'
        });
        compEvent.fire();
        
	}
})