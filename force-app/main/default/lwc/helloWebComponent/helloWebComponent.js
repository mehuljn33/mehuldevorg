/* eslint-disable no-console */
import { LightningElement,track,wire,api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
//import {ShowToastEvent}  from 'lightning/platformShowToastEvent';
var fields = ['CFS_Item__c.Book_Author__c','CFS_Item__c.Book_name__c','CFS_Item__c.Book_Publication__c'] ;
export default class HelloWebComponent extends LightningElement {
    @api recordId;
    @track author;
    @track name;
    @track publication;
    @track error;
    
    @wire(getRecord,{recordId : '$recordId',fields})
    wiregetrecmethod(response){
        
            if(response.data) {
                this.author = response.data.fields.Book_Author__c.value;   
                this.name = response.data.fields.Book_name__c.value;   
                this.publication = response.data.fields.Book_Publication__c.value;      
            }
            if(response.error) {
                this.error = response.error;
            }
        
    }

    openRelated(){
        this.dispatchEvent(new CustomEvent('getrelated',{detail:this.recordId}));
        console.log('inside open related');
        console.log(this.recordId);
    }
}