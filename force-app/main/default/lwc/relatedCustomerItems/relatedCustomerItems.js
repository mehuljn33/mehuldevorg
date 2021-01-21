/* eslint-disable no-console */
import { LightningElement, wire, track,api } from 'lwc';
import getCustItems from '@salesforce/apex/ItemBuyerController.getCustItems';

export default class RelatedCustomerItems extends LightningElement {
    @track lstCustItems=[];
    @api recordId;
    @track columns = [
        {label : "Name",
        fieldName : "Name",
        type : "text"
        },
        {label : "Customer Name",
        fieldName : "CustomerName",
        type : "text"
        },
        {label : "Item Code",
        fieldName : "ItemCode",
        type : "text"
        },
        {label : "Status",
        fieldName : "Status",
        type : "text"
        },
        {label : "Customer Id",
        fieldName : "CustomerId",
        type : "text"
        }
    ];
    @wire(getCustItems,{strItemId : '$recordId'}) 
    wireMethod(response){
        var i = 0 ;
        var eachItem ;
        if (response.data){
            let curList = [];
            console.log('in if wire' );
            console.log(response.data);
            //this.lstCustItems = response.data;
            for(i = 0; i<response.data.length; i++){
                eachItem = {};
                eachItem.CustomerName = response.data[i].CSF_Customer__r.Name;
                eachItem.CustomerId = response.data[i].CSF_Customer__r.Id;
                eachItem.Id = response.data[i].Id;
                eachItem.Name = response.data[i].Name;
                eachItem.Status = response.data[i].Status__c;
                eachItem.ItemCode = response.data[i].Item_Code__c;
                curList.push(eachItem);
                
                console.log("in for loop wiremethod : ")
                
            }
            this.lstCustItems = curList;
        }
        
        console.log(" in wire method, this.lstCustItems : ");
        console.log(this.lstCustItems);
    }

}