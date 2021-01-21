/* eslint-disable no-alert */
/* eslint-disable no-console */
import { LightningElement, api, wire, track } from 'lwc';
import getEventList from '@salesforce/apex/SalesRouteController.getEventList';
import getMarkers from '@salesforce/apex/SalesRouteController.getMarkers';
//import { refreshApex } from '@salesforce/apex';

export default class SalesRoute extends LightningElement {
    
    @api events;
    @api currentDate;
    @api eventDate = new Date();
    @api eventList = [];
    @api error;
    @api mapEventMarkers = [];
    @track markersResult;
    @track listResult;
    @track mapMarkers = [
        {
            location: {
                Street: "Sarawati Vihar",
                City: "Gurugram",
                Country: "India"
            },

            icon: 'custom:custom26',
            title: "Location 1",
        },
        {
            location: {
                Street : 'Sohna Road',
                City: 'Gurugram',
                Country: 'India'
            },

            icon: 'custom:custom96',
            title: 'Location 2',
        }
    ]


    @wire(getEventList,{dtSelected : '$eventDate'})
    wireMethod(response){
        this.listResult = response;
        if(response.data){
            this.eventList = response.data;
            getMarkers({lstEvent:response.data}).then(result=>{
                this.mapEventMarkers = JSON.parse(result);
                //this.mapEventMarkers = result;
                console.log('@@result');
                console.log(result);
                console.log(this.mapMarkers);
                console.log(this.mapEventMarkers);
            })
            .catch(error=>{
                this.errorstr = error; 
                console.log('@@error');
                console.log(error);   
            })
        }
        if(response.error){
            this.error = response.error;
        }
    }

    /*@wire(getMarkers,{lstEvents: '$eventList'}) 
    wireMethod2(response){
        alert('getmarker');
        this.markersResult = response;
        if(response.data){
            this.mapEventMarkers = response.data;
            console.log('@@in marker');
            console.log(this.mapEventMarkers);
        }
        if(response.error){
            this.error = response.error;
        }
    } */

    setCurrentDate(event){
        this.eventDate = event.target.value;
        //return refreshApex(this.listResult);
    }

    
}