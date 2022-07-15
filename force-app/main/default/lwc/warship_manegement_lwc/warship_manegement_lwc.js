import { LightningElement , wire, track} from 'lwc';

import SUPPLYNAME_FIELD from '@salesforce/schema/Warship_Supply__c.Supply__r.Name';
import SUPPLYQUANTITY_FIELD from '@salesforce/schema/Warship_Supply__c.Supply__r.Quantity__c';
import getWarships from '@salesforce/apex/lwc_ManegementWarships.getWarships';
import getSupplies from '@salesforce/apex/lwc_ManegementWarships.getSupllies';

const COLUMNS = [
    { label: 'Supply Name', fieldName: SUPPLYNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Supply Quantity', fieldName: SUPPLYQUANTITY_FIELD.fieldApiName, type: 'text' },
];

let i=0;
export default class Warship_manegement_lwc extends LightningElement {

    @track items = []; 
    @track value = ''; 
    @track chosenValue = '';

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

    handleChange(event) {
        const selectedOption = event.detail.value;
        this.chosenValue = selectedOption;
    }

    get selectedValue(){
        return this.chosenValue;
    }

    columns = COLUMNS;
    @wire(getSupplies, {wId: '$chosenValue'})
    supplies;


}