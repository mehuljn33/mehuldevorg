/* eslint-disable no-console */
/* eslint-disable no-alert */
import { LightningElement, api,track } from 'lwc';
export default class contactSelector extends LightningElement {
   
    @api accounts;
    @track error;
    openDetail(event){
        var currentSFDCId;
        //alert('card on click'+event.target.dataset);
        
        currentSFDCId = event.currentTarget.id;
        currentSFDCId = currentSFDCId.split('-')[0];
        console.log('on click id'+event.currentTarget.id);
        this.dispatchEvent(new CustomEvent('getdetail',{detail:currentSFDCId}));
    }
}