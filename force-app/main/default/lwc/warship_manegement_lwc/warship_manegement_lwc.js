import { LightningElement , wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import SUPPLYNAME_FIELD from '@salesforce/schema/Warship_Supply__c.Supply_Name__c';
import SUPPLYQUANTITY_FIELD from '@salesforce/schema/Warship_Supply__c.Quantity__c';
import MILSTONE_NAME_FIELD from '@salesforce/schema/Milestone__c.Name';
import MILSTONE_DUEDATE_FIELD from '@salesforce/schema/Milestone__c.Due_Date__c';
import MILSTONE_ENDDATE_FIELD from '@salesforce/schema/Milestone__c.End_Date__c';
import MILSTONE_STATUS_FIELD from '@salesforce/schema/Milestone__c.Status__c';
import RESOURCENAME_FIELD from '@salesforce/schema/Warship_Resource__c.Resource_Name__c';
import RESOURCEQUANTITY_FIELD from '@salesforce/schema/Warship_Resource__c.Quantity__c';

import getWarships from '@salesforce/apex/lwc_ManegementWarships.getWarships';
import getWarshipsData from '@salesforce/apex/lwc_ManegementWarships.getDataWarship';
import getSupplies from '@salesforce/apex/lwc_ManegementWarships.getSupllies';
import getMilestones from '@salesforce/apex/lwc_ManegementWarships.getMilestones';
import getResources from '@salesforce/apex/lwc_ManegementWarships.getResources';

import getAddSupply from '@salesforce/apex/lwc_ManegementWarships.getAddSupply';
import updateWarSup from '@salesforce/apex/lwc_ManegementWarships.updateWarSup';

import getFinishMilestone from '@salesforce/apex/lwc_ManegementWarships.getFinishMilestone';
import updateMilestone from '@salesforce/apex/lwc_ManegementWarships.updateMilestone';

const SUPPLY_COLUMNS = [
    { label: 'Supply Name', fieldName: SUPPLYNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Supply Quantity', fieldName: SUPPLYQUANTITY_FIELD.fieldApiName, type: 'text' },
    {label: 'Actions', type: 'button', typeAttributes: {  
        label: 'Add Quantity',  
        name: 'Add Quantity',  
        title: 'Add Quantity',  
        disabled: false,  
        value: 'AddQuantity',
        iconName: 'utility:add'
    }},  
];

const MILESTONE_COLUMNS = [
    { label: 'Milestone Name', fieldName: MILSTONE_NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Due Date', fieldName: MILSTONE_DUEDATE_FIELD.fieldApiName, type: 'date' },
    { label: 'End Date', fieldName: MILSTONE_ENDDATE_FIELD.fieldApiName, type: 'date' },
    { label: 'Status', fieldName: MILSTONE_STATUS_FIELD.fieldApiName, type: 'text' },
    {label: 'Actions', type: 'button', typeAttributes: {  
        label: 'Finish Milestone',  
        name: 'Finish Milestone',  
        title: 'Finish Milestone',  
        disabled: false,  
        value: 'FinishMilestone',
        iconName: 'action:goal'
    }},
];

const RESOURCE_COLUMNS = [
    { label: 'Resource Name', fieldName: RESOURCENAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Resource Quantity', fieldName: RESOURCEQUANTITY_FIELD.fieldApiName, type: 'text' },
];

let i=0;
export default class Warship_manegement_lwc extends LightningElement {

    @track items = []; 
    @track value = ''; 
    @track chosenValue = '';
    showModal = false;
    showModalMilestone = false;
    isLoading = false;
    showComboBox = true;

    addQuantity;
    supplyColumns = SUPPLY_COLUMNS;
    milestoneColumns = MILESTONE_COLUMNS;
    resourceColumns = RESOURCE_COLUMNS;
    warshipData;
    supplies;
    milestones;
    resources;
    updateRecId;
    
    toggleComboBox(){
        this.showComboBox = !this.showComboBox;
    }

    @track availableQuantity;
    addWarSup;
    finishMilestone;

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
        this.isLoading = true;

        getWarshipsData({wId: this.chosenValue})
            .then((result)=> {
                this.warshipData = result;
                this.error = undefined;               
            })
            .catch((error) =>{
                this.warshipData = undefined;
                this.error = error;
                console.log(error.body.message);
            });

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

        getResources({wId: this.chosenValue})
            .then((result)=> {
                this.resources = result;
                this.error = undefined;
                this.isLoading = false;
            })
            .catch((error) =>{
                this.resources = undefined;
                this.error = error;
                console.log(error.body.message);
            });
    }
    toggleModalMilestone(){
        this.showModalMilestone = !this.showModalMilestone;
    }
    get milestoneId() {
        return this.finishMilestone?.Id;
    }
    get milestoneName() {
        return this.finishMilestone?.Name;
    }
    get milestoneDueDate() {
        return this.finishMilestone?.Due_Date__c;
    }
    get milestoneWarship() {
        return this.finishMilestone?.Warship__r.Name;
    }

    toggleModal(){
        this.showModal = !this.showModal;
    }
    get supplyId() {
        return this.addWarSup?.Id;
    }
    get supplyName() {
        return this.addWarSup?.Supply_Name__c;
    }
    get supplyQuantity() {
        return this.addWarSup?.Quantity__c;
    }
    get supplyAvailableQuantity() {
        return 'Enter Quantity (Máx.'+this.addWarSup?.Available_Quantity__c+')';
    }

    callRowAction( event ) {  
        this.showModal = !this.showModal; 
        const recId =  event.detail.row.Id;   
        if (this.showModal) {
            getAddSupply({ws_Id: recId})
            .then((result)=> {
                this.addWarSup= result;
                this.error = undefined;
            })
            .catch((error)=> {
                this.addWarSup = undefined;
                this.error = error;
                console.log(error.body.message);
            });
        }
    }

    handleInputChange(event){
        this.addQuantity = event.target.value;
    }  

    updateQuantity(event){       
        if ((this.addQuantity <1) || (this.addQuantity > this.addWarSup?.Available_Quantity__c)) {
            alert("Quantity must be between 0 and "+this.addWarSup?.Available_Quantity__c);
            this.template.querySelector("lightning-input[data-id=inputModal]").value="";
            this.template.querySelector("lightning-input[data-id=inputModal]").focus();
        }else{
            updateWarSup({ws_Id: this.supplyId, quantity:this.addQuantity})
            .then((result)=> {this.supplies = result; }).catch((error)=> {this.error = error;});
            const toastEvent = new ShowToastEvent({
                message:'Record Update successfully',         
                variant:'success'
            });
            this.dispatchEvent(toastEvent);
            this.showModal = !this.showModal;
        }   
    }

    callRowActionMilestone( event ) {  
        this.showModalMilestone = !this.showModalMilestone; 
        const recId =  event.detail.row.Id;   
        
        getFinishMilestone({milestone_Id: recId})
        .then((result)=> {
            this.finishMilestone= result;
            this.error = undefined;
        })
        .catch((error)=> {
            this.finishMilestone = undefined;
            this.error = error;
            console.log(error.body.message);
        });
        
    }

    updateMilestone(event){      
        
        updateMilestone({milestone_Id: this.milestoneId})
        .then((result)=> {this.milestones = result}).catch((error)=> {this.error = error});

        this.showModalMilestone = !this.showModalMilestone;
    }

}