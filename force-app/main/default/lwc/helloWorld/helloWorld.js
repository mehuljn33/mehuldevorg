import { LightningElement, track , api, wire} from 'lwc';
import mymethod45 from '@salesforce/apex/HelloWorldController.mymethod';
import mymethod2 from '@salesforce/apex/HelloWorldController.mymethod2';
//import processSelected from '@salesforce/apex/HelloWorldController.processSelected';
import LAST_NAME from '@salesforce/schema/Contact.LastName';
import ID from '@salesforce/schema/Contact.Id';
import EMAIL from '@salesforce/schema/Contact.Email';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
    export default class HelloWorld123 extends LightningElement {
        @track greeting = 'My World';
        @api showmessage;
        @api teststr;
        @api errorstr;
        @track lstCon;
        @track lstCon1;
        @track userDisplay;
        @track apexResult;
        @track selectedContacts;
        @track newString;
        @track columns = [{
            label:"Last Name",
            fieldName: "LastName",
            type : "text",
            editable: true
        },
        {
            label:"Email Name",
            fieldName: "Email",
            type : "text",
            editable: true
        }
        ]

        @wire(mymethod45) lstCon;
        @wire(mymethod2,{strText :'$greeting'}) userDisplay;
        @wire(mymethod45)
        wireMethod(response){
            this.apexResult = response;
            if(response.data){
                this.lstCon1 = response.data;
            }
            if(response.error){
                this.lstCon1 = response.error;
            }
        }

        @wire(mymethod2, {strText :'$greeting'})
        wireMethod(response){
            if(response.data){
                this.newString = response.data;
            }
            if(response.error){
                this.errorstr = response.error;
            }
        }

        changeHandler(event) {
            this.greeting = event.target.value;
        }

        get mymessage(){
            var str = 'mehul123' + Math.random();
            return str ;
        }


        handleClick(){
            mymethod2().then(result=>{
                this.teststr = result;
            })
            .catch(error=>{
                this.errorstr = error;    
            })
            
        }

        handleSave(event) {
            const fields ={};
            fields[ID.fieldApiName] = event.detail.draftValues[0].Id;
            fields[LAST_NAME.fieldApiName] = event.detail.draftValues[0].LastName;
            fields[EMAIL.fieldApiName] = event.detail.draftValues[0].Email;
            // eslint-disable no-alert
            //alert(ID.fieldApiName);

            //const recordInput = {fields};
            updateRecord(event.detail.draftValues)
                .then(() => {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Contact updated',
                            variant: 'success'
                        })
                    );
                    // Clear all draft values
                    this.draftValues = [];

                    // Display fresh data in the datatable
                    return refreshApex(this.apexResult);
                }).catch(error => {
                    
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error creating record',
                            message: error,
                            variant: 'error'
                        })
                    );
                });

                this.selectedContacts = event.detail.getselectedRows;
                //processSelected,{ lstContacts :'$this.selectedContacts'});
        }

        
    }

/*
import { LightningElement, track } from 'lwc';
export default class HelloWorld extends LightningElement {
    @track greeting = 'World';
    changeHandler(event) {
        this.greeting = event.target.value;
    }
}*/