({
	myAction : function(component, event, helper) {
      
		var action = component.get("c.getAcc");
		 action.setParams({  recordId : component.get("v.name")  });
        var account;
         action.setCallback(this,function(response) {
            
		 account =  response.getReturnValue();
		 alert(response.getReturnValue());
              });
		 $A.enqueueAction(action);
	component.set("v.name","new value");
        component.set("v.acc",account);
	}
})