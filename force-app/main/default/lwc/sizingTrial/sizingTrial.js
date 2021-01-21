/* eslint-disable no-console */
import { LightningElement, track, wire } from 'lwc';
import { getPicklistValues, getObjectInfo } from 'lightning/uiObjectInfoApi';
import getAccountName from '@salesforce/apex/SalesRouteController.getAccountName';

//1. This JS file shows that wire methods will be called before connectedCallback 
//2. The referred wire method will be called automatically whenever any reactive entity is referred in 
//   another wire method.
//   'getPicklistValues' method refers 'RTId', so 'getObjectInfo' is called automatically
//3. If in onchange, any reactive value is being updated then the wire method using that reactive
//  value will be called automatically and this will be reflected on the html page at the same time.
//  'onchange' method refers 'selectedSla', hence 'getAccountName' is called automatically after 'onchange'.

export default class SizingTrial extends LightningElement {
    @track selectedSla;
    @track optionsSla;
    @track RTId;
    @track error;
    @track accountName;
    connectedCallback(){
        //this.RTId = this.objectInfo.data.defaultRecordTypeId;
        console.log('in connected callback');
    }

    @wire(getPicklistValues,{recordTypeId : '$RTId', fieldApiName : 'Account.SLA__c'})
    wireMethod(response){
        console.log('in  wiremethod');
        console.log(response.data);
        if(response.data){
            this.optionsSla = response.data.values;
        }
        if(response.error){
            this.error = response.error;
        }
    }

    @wire(getObjectInfo,{objectApiName : 'Account'}) 
    getRTId(response){
        console.log('in  getRTId');
        console.log(response.data);
        if(response.data){
            this.RTId =  response.data.defaultRecordTypeId;
        } 
        if(response.error){
            this.error = response.error;
        }
    }

    @wire(getAccountName,{strSLA : '$selectedSla'})
    wireMethod2(response){
        console.log('in  getAccountName');
        console.log(this.selectedSla);
        console.log(response.data);
        if(response.data){
            this.accountName = response.data;
        }
        if(response.error){
            this.error = response.error;
        }
    }

    onchange(event){
        this.selectedSla = event.target.value;
    }
}