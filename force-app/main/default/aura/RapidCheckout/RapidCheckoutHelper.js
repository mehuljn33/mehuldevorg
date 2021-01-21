({
	createList : function(component,event,helper) {
        
        var lstItem = component.get("v.ItemCodeList");
        lstItem.push(component.get("v.ItemCode"));
        component.set("v.ItemCodeList",lstItem);
    },
    onSubmit : function(component,event,helper) {
        
       var lstItem = component.get("v.ItemCodeList");
       alert(lstItem);
    },
})