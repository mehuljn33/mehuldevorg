({
	navigate : function(component, event, helper) {
    var testemail = component.get("v.name");
	component.set("v.email", testemail);
    }
})