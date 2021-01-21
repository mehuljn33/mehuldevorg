({
    SearchHelper: function(component, event) {
        // show spinner message
        component.find("Id_spinner").set("v.class" , 'slds-show');
        var action = component.get("c.getItemList");
        var PLValue = component.find("TypeOfItem").get("v.value");
        var categoryValue = component.find("Category").get("v.value");
        
        component.set("v.PLValue",PLValue); 
        
        action.setParams({
            'strKeyword': component.get("v.searchKeyword"),
            'strType' :  PLValue,
            'strCategory' : categoryValue
        });
        action.setCallback(this, function(response) {
           // hide spinner when response coming from server 
            component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                
                // if storeResponse size is 0 ,display no record found message on screen.
                if (storeResponse.length == 0) {
                    component.set("v.Message", true);
                } else {
                    component.set("v.Message", false);
                    component.set("v.showResults", true);
                }
                
                // set numberOfRecord attribute value with length of return value from server
                component.set("v.TotalNumberOfRecord", storeResponse.length);
                
                // set searchResult list with return value from server.
                component.set("v.searchResult", storeResponse); 
                
            }else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    createCustItem : function(component,event,selectedContacts) {
        // show spinner message
        component.find("Id_spinner").set("v.class" , 'slds-show');
        //var lstids = JSON.stringify( component.get("v.cartList"));
       // alert(selectedContacts);
        var lstids = JSON.stringify(selectedContacts);
        var customerId = component.get("v.recordId");
        var action = component.get("c.createCI");
        
        action.setParams({
            'lstids': lstids,
            'customerId' : customerId
        });
        action.setCallback(this, function(response) {
           // hide spinner when response coming from server 
            component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
                component.set("v.cartList",storeResponse);
                
                
            }else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    insertCustI : function(component,event,listOfCI) {
        
        var lstCI = JSON.stringify(listOfCI);
        var action = component.get("c.insertCI");
        
        action.setParams({
            'lstCI': lstCI
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var storeResponse = response.getReturnValue();
            }
        });
        $A.enqueueAction(action);
    },
    
    
    showToastAddCart : function(component, event, helper) {
      // Use \n for line breake in string 
        var sMsg = 'Item added to cart !';
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'dismissible',
            message: sMsg,
            type : 'success',
            duration : 2000
        });
        toastEvent.fire();
    },
    
    showToastFinish : function(component, event, helper) {
      // Use \n for line breake in string 
        var sMsg = 'Payment done, you may provide the items to the customer now.';
        
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            mode: 'pester',
            message: sMsg,
            type : 'success',
            duration : 5000
        });
        toastEvent.fire();
    },
    createRapidList : function(component,event,helper) {
        
        var lstItem = component.get("v.cartList");
        lstItem.push(component.get("v.ItemCode"));
        component.set("v.cartList",lstItem);
    },
    checkLateFee : function(component,event,helper) {
        var action = component.get("c.calculateLateFee");
        
        action.setParams({
            'customerId': component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.LateFee",response.getReturnValue());
                if (response.getReturnValue() > 0){
                    component.set("v.DefaultSelection",false);
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    validateItems: function(component,event,helper) {
        var lstItem = JSON.stringify(component.get("v.cartList"));
        var action = component.get("c.verifyItems");
        //alert('1');
        action.setParams({
            'customerId': component.get("v.recordId"),
            'strCIList' : lstItem
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.CartMessage",response.getReturnValue());
                if (response.getReturnValue() == ''){
                   //alert('2');
                    component.set("v.paymentWindow",true);
        			component.set("v.DisplayCart",false);
                    component.set("v.ProceedPayDisb","false");
                } else {
                    //alert('3');
                    component.set("v.paymentWindow",false);
        			component.set("v.DisplayCart",true);
                    component.set("v.ProceedPayDisb","true");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    getCategories : function(component,event,helper){
        var action = component.get('c.fetchCategories');
        action.setCallback(this, function(actionResult) {
            var result=actionResult.getReturnValue();
            var optionsMap = [];
            for(var key in result){
                    optionsMap.push({key: key, value: result[key]});
            }
            component.set("v.categoryMap",optionsMap);
         
        });
        $A.enqueueAction(action);
    }

})