({
    doInit: function (component,event,helper) {
        helper.checkLateFee(component,event,helper);
        helper.getCategories(component,event,helper);
    },
    
    Search: function(component, event, helper) {
        var searchField = component.find('searchField');
        var isValueMissing = searchField.get('v.validity').valueMissing;
        // if value is missing show error message and focus on field
        if(isValueMissing) {
            searchField.showHelpMessageIfInvalid();
            searchField.focus();
        }else{
          // else call helper function 
            helper.SearchHelper(component, event);
        }
    },
    //Select all contacts
    handleSelectAllContact: function(component, event, helper) {
        var getID = component.get("v.searchResult");
        var checkvalue = component.find("selectAll").get("v.value");        
        var checkContact = component.find("checkContact"); 
        if(checkvalue == true){
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",true);
            }
        }
        else{ 
            for(var i=0; i<checkContact.length; i++){
                checkContact[i].set("v.value",false);
            }
        }
    },
     
    //Process the selected contacts
    handleSelectedContacts: function(component, event, helper) {
        var selectedContacts = component.get("v.cartList");
        var checkvalue = component.find("checkContact");
         
        if(!Array.isArray(checkvalue)){
            if (checkvalue.get("v.value") == true) {
                selectedContacts.push(checkvalue.get("v.text"));
            }
        }else{
            for (var i = 0; i < checkvalue.length; i++) {
                if (checkvalue[i].get("v.value") == true) {
                    selectedContacts.push(checkvalue[i].get("v.text"));
                }
            }
        }
        //var cartList = component.get("v.cartList");
        //cartList.push(selectedContacts);
        component.set("v.cartList",selectedContacts);
        helper.showToastAddCart(component, event, helper);
       
    },
    
    goToCart: function(component, event, helper) {
        var SelectedIds = component.get("v.cartList");
        helper.createCustItem(component, event,SelectedIds);
        component.set("v.DisplayCart",true);
        component.set("v.showResults", false);
        component.set("v.SearchArea", false);
        component.set("v.rapidCheckout",false);
        
    },
    
    showPayment: function(component, event, helper) {
        helper.validateItems(component, event, helper);
    },
    
    insertRecords : function(component, event, helper) {
       var listOfCI = component.get("v.cartList");
        
       helper.insertCustI(component, event,listOfCI); 
       helper.showToastFinish(component, event, helper); 
       $A.get("e.force:closeQuickAction").fire() 
    },
    
    calculatePrice : function(component, event, helper) {
       var total = 0; 
       var flagStartDate = false; 
       var flagEndDate = false;  
       const today = new Date();
       const tomorrow = new Date(today);
       const twoMonths = new Date(today);
       
       var maxDays = $A.get("$Label.c.Max_Borrow_Period"); 
        
       twoMonths.setDate(twoMonths.getDate() + parseInt(maxDays)); 
       tomorrow.setDate(tomorrow.getDate() - 1);
       //alert(tomorrow); 
       var allRows = component.get("v.cartList");
       for (var i = 0; i < allRows.length; i++) {
           if ( new Date(allRows[i].Start_Date__c) < tomorrow){
               flagStartDate = true;
           }
           if ( new Date(allRows[i].End_Date__c) > twoMonths){
               flagEndDate = true;
           }
            var diff = new Date(allRows[i].End_Date__c) - new Date(allRows[i].Start_Date__c);
            diff = diff/8.64e7;
            if (allRows[i].Status__c == 'Borrow') {
                if (allRows[i].Item_type__c == 'Book')
					allRows[i].Borrowed_Price__c = diff;
                else
                    allRows[i].Borrowed_Price__c = diff*2;
            } else {
                allRows[i].Borrowed_Price__c = allRows[i].Item_s_Purchase_Price__c; 
            }
            total += allRows[i].Borrowed_Price__c;
       }
       if(flagStartDate){
               component.set("v.StartDateMessage","Borrowing start date cannot be less than today.");
               component.set("v.ProceedPayDisb","true");
       } else if(flagEndDate){
               component.set("v.EndDateMessage","Borrowing end date cannot be more than 2 months.");
               component.set("v.ProceedPayDisb","true");
       } else {
           	   component.set("v.StartDateMessage","");
               component.set("v.EndDateMessage","");
               component.set("v.ProceedPayDisb","false"); 
       }  
	   component.set("v.totalAmount", total);	 
       component.set("v.cartList", allRows); 
    },
    
    removeItem : function(component, event, helper) {
    	var newList = component.get("v.cartList");
        //Get the target object
        var selectedItem = event.currentTarget;
        //Get the selected item index
        var index = selectedItem.dataset.record;
        newList.splice(index, 1);
        component.set("v.cartList", newList);  
         $A.enqueueAction(component.get('c.calculatePrice'));
    },

    addRapidCode : function(component, event, helper){
        if (event.which == 13){
            helper.createRapidList(component, event, helper);
            component.set("v.ItemCode","");
        }    
        
    },
 
    toggleMode : function(component, event, helper){
        var radioVal = component.get("v.RadioValue")  ;
        if (radioVal == 'Rapid'){
           component.set("v.rapidCheckout",true);
        } else {
           component.set("v.SearchArea",true); 
        }
        component.set("v.DefaultSelection", false)    	
        
    },
    
    backToSearch : function(component, event, helper){
        var newList = component.get("v.cartList");
        component.set("v.DisplayCart", false) ;
        component.set("v.showResults", true) ;
        component.set("v.SearchArea", true);
        component.set("v.cartList", newList);
        
    }
})