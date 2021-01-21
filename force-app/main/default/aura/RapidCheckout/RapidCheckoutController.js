({
    addToCart : function(component, event, helper){
        if (event.which == 13){
            helper.createList(component, event, helper);
            component.set("v.ItemCode","");
        }    
        
    },
    onSubmit : function(component, event, helper){
       var lstItem = component.get("v.ItemCodeList");
       alert(lstItem);
       
    }
    
})