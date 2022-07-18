import { LightningElement , wire, track} from 'lwc';
import SUPPLYNAME_FIELD from '@salesforce/schema/Warship_Supply__c.Supply_Name__c';
import SUPPLYQUANTITY_FIELD from '@salesforce/schema/Warship_Supply__c.Quantity__c';
import MILSTONE_NAME_FIELD from '@salesforce/schema/Milestone__c.Name';
import MILSTONE_DUEDATE_FIELD from '@salesforce/schema/Milestone__c.Due_Date__c';
import MILSTONE_STATUS_FIELD from '@salesforce/schema/Milestone__c.Status__c';

import getWarships from '@salesforce/apex/lwc_ManegementWarships.getWarships';
import getSupplies from '@salesforce/apex/lwc_ManegementWarships.getSupllies';
import getMilestones from '@salesforce/apex/lwc_ManegementWarships.getMilestones';

const SUPPLY_COLUMNS = [
    { label: 'Supply Name', fieldName: SUPPLYNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Supply Quantity', fieldName: SUPPLYQUANTITY_FIELD.fieldApiName, type: 'text' },
    {type: 'button', typeAttributes: {  
        label: 'Add Quantity',  
        name: 'Add Quantity',  
        title: 'Add Quantity',  
        disabled: false,  
        value: 'AddQuantity',  
        iconPosition: 'left'  
    }},  
];

const MILESTONE_COLUMNS = [
    { label: 'Milestone Name', fieldName: MILSTONE_NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Due Date', fieldName: MILSTONE_DUEDATE_FIELD.fieldApiName, type: 'date' },
    { label: 'Status', fieldName: MILSTONE_STATUS_FIELD.fieldApiName, type: 'text' },
];

let i=0;
export default class Warship_manegement_lwc extends LightningElement {

    @track items = []; 
    @track value = ''; 
    @track chosenValue = '';
    supplyColumns = SUPPLY_COLUMNS;
    milestoneColumns = MILESTONE_COLUMNS;
    supplies;
    milestones;

    @wire(getWarships)
    wiredWarships({ error, data }) {
        if (data) {
            for(i=0; i<data.length; i++)  {
                this.items = [...this.items ,{value: data[i].Id , label: data[i].Name} ];                                   
            }                
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }
    get warshipOption() {
        return this.items;
    }
    get selectedValue(){
        return this.chosenValue;
    }

    handleChange(event) {
        const selectedOption = event.detail.value;
        this.chosenValue = selectedOption;
        
        getSupplies({wId: this.chosenValue})
            .then((result)=> {
                this.supplies = result;
                this.error = undefined;
            })
            .catch((error) =>{
                this.supplies = undefined;
                this.error = error;
                console.log(error.body.message);
            });
        
        getMilestones({wId: this.chosenValue})
        .then((result)=> {
            this.milestones = result;
            this.error = undefined;
        })
        .catch((error) =>{
            this.milestones = undefined;
            this.error = error;
            console.log(error.body.message);
        });
}
}