import { LightningElement,api,track } from 'lwc';

export default class FileUpload extends LightningElement {
    @api recordId="a2f0K00000B5osAQAR";
    @track names=[];
    displayName(event){
        // eslint-disable-next-line no-alert
        var fileList = this.names;        
        fileList.push(event.detail.files[0].name);
        this.names = fileList; 
        
    }

    
}