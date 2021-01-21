/* eslint-disable no-console */
import { LightningElement,wire,track } from 'lwc';
import getItems from '@salesforce/apex/ItemBuyerController.getItems';

export default class ItemBuyers extends LightningElement {
    @track error;
    @track data;
    @track response;
    @track showItemTable = true;
    @track showDetailSection = false;
    @track listItems;
    @track selectedItem ;
    @track columns = [
        {   label : "Item Name",
            fieldName : "Name",
            type : "text"
        }
    ];

    @wire(getItems)
    wireMethod(response){
        this.response = response;
        if (response.data) {
            this.data = response.data;
        }
        if(response.error) {
            this.error  = response.error;
        }
        console.log(this.data);
    }

    pushToList(event){
        var selectedRows = event.detail.selectedRows;
        var lstRecordIds = [];
        var i;
        for(i=0;i<selectedRows.length;i++){
            lstRecordIds.push(selectedRows[i].Id);
        }
        this.listItems = lstRecordIds;
        console.log( "inside pushtolist");
        console.log( this.listItems);
    }

    showDetailed(){
        this.showItemTable = false;
        this.showDetailSection = true;
        console.log( "inside showdetailed");
        console.log( this.listItems);
    }

    backToItemTable(){
        this.showItemTable = true;
        this.showDetailSection = false;
    }

    displayRelated(event){
        console.log('in display related' + event.detail);
        this.selectedItem = event.detail;
        this.showRelatedSection = true;
        this.showItemTable = false;
        this.showDetailSection = false;
    }

    backToDetail(){
        this.showItemTable = false;
        this.showDetailSection = true;
        this.showRelatedSection = false;
    }
}