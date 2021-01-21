/* eslint-disable no-console */
/* eslint-disable no-alert */
import { LightningElement, api,wire,track } from 'lwc';
import getEventList from '@salesforce/apex/SalesRouteController.getEventList';
import getMarkers from '@salesforce/apex/SalesRouteController.getMarkers';

export default class EventList extends LightningElement {
    @api events;
    @api eventDate ;
    @api eventList = [];
    @api error;
    @api mapEventMarkers = [];
    @track showChild;
    
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
        if(response.data){
            this.eventList = response.data;
            this.showChild = true;
        }
        if(response.error){
            this.error = response.error;
        }
    }

    @wire(getMarkers,{lstEvents: '$eventList'}) 
    wireMethod2(response){
        if(response.data){
            this.mapEventMarkers = response.data;
            console.log(this.mapEventMarkers);
        }
        if(response.error){
            this.error = response.error;
        }
    } 

}