/* eslint-disable no-console */
/* eslint-disable no-alert */
import { LightningElement, api, track,wire } from 'lwc';
import getAccount from '@salesforce/apex/ConSelectorController.getAccount';
import returnAccount from '@salesforce/apex/ConSelectorController.returnAccount';
import updateSelectedCon from '@salesforce/apex/ConSelectorController.updateSelectedCon';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import {refreshApex} from '@salesforce/apex';
//import { updateRecord } from 'lightning/uiRecordApi';

export default class conSelectApp extends LightningElement {
    @api
    searchKey = '';
    @api
    accList;
    @api
    selectedContact;
    @track
    contactPhone;
    @api resultResponse;

    @wire(returnAccount,{objAccount : '$this.selectedContact'})
    wireMethod(response){
        this.resultResponse = response;
    }

    searchAccount() {
        let searchText = this.searchKey;
        getAccount({ strSearchKey: searchText }).then(result => {
            this.accList = result;
        })
        .catch(error=>{
            console.log(error.body);
            const errorEvt = new ShowToastEvent({
                title: 'Error',
                message: 'Please contact system Admin, the following error occurred : \n'+ error.body.message,
                variant: 'error'
            });
            this.dispatchEvent(errorEvt);
        });
        this.selectedContact = null;
    }
    onInputClick(event) {
        this.searchKey = event.target.value;
    }
    displaySelected(event) {
        var i;
        console.log('event param' + event.detail);
        for (i = 0; i < this.accList.length; i++) {
            console.log(this.accList[i].Id);
            if (this.accList[i].Id === event.detail) {
                console.log('inside if' + this.accList);
                this.selectedContact = this.accList[i];
            }
        }
        console.log('this.selectedContact' + this.selectedContact.Id);
    }
    checkEnter(event) {
        if (event.which === 13) {
            this.searchAccount();
        }
    }
    saveSelected() {
        let objCon1 = JSON.stringify(this.selectedContact);
        let objCon2 = JSON.parse(objCon1);
        objCon2.Phone = this.contactPhone;
        updateSelectedCon({ objContact: objCon2 }).then(result => {
            const successEvt = new ShowToastEvent({
                title: result,
                message: 'Your record has been succesfully updated',
                variant: 'success'
            });
            this.dispatchEvent(successEvt);
            //window.reload();
            //refreshApex(this.selectedContact);
            
        });
        //updateRecord({ fields: { Id: this.selectedContact.Id } });
    }
    onclickphone(event) {
        this.contactPhone = event.target.value;
    }
}