import { LightningElement, wire, track } from 'lwc';
import getContacts from '@salesforce/apex/LWCExampleController.getContacts';
import getShowTotalPayment from '@salesforce/apex/LWCExampleController.getShowTotalPayment';
import getRecentPaymentDate from '@salesforce/apex/LWCExampleController.getRecentPaymentDate';
import getPaymentByContact from '@salesforce/apex/LWCExampleController.getPaymentByContact';
import createPayment from '@salesforce/apex/LWCExampleController.createPayment';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import PAYMENT_OBJECT from '@salesforce/schema/Payment__c';
import NAME_FIELD from '@salesforce/schema/Payment__c.Name';
import AMOUNT_FIELD from '@salesforce/schema/Payment__c.Amount__c';
import CONTACT_FIELD from '@salesforce/schema/Payment__c.Contact__c';



// datatable columns
const columns = [
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
    }, {
        label: 'Amount',
        fieldName: 'Amount__c',
        type: 'text',
        editable: true,
    }, {
        label: 'LastName',
        fieldName: 'LastName',
        type: 'text',
        editable: true,
    }, {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
        editable: true
    }
];

const columns1 = [
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
    }
];
export default class LwcPaymentsInformation extends LightningElement {
    columns = columns;
    columns1 = columns1;
    @track contacts;
    @track payments=[];  
    @track totalPaymentAmount;
    @track mostRecentPaymentDate;
    @track selectedId;
    @track selectedflag;
    saveDraftValues = [];
    saveDraftValues1 = [];
    @track name = NAME_FIELD;
    @track amount = AMOUNT_FIELD;
    @track contact = CONTACT_FIELD;
    rec = {
        Name : this.name,
        Amount__c : this.amount,
        Contact__c : this.contact
    }

    @wire(getContacts)
    cons(result) {
        this.contacts = result;
        if (result.error) {
            this.contacts = undefined;
        }
    };
    
    handleRowSelection = event => {
        var selectedRows = event.detail.selectedRows;
        if (selectedRows.length > 1) {
            var el = this.template.querySelector('lightning-datatable');
            selectedRows = el.selectedRows = el.selectedRows.slice(1);
            this.showNotification();
            event.preventDefault();
            return;
        }
        else {
            if (selectedRows != null && selectedRows[0] != null) {
                this.selectedId = selectedRows[0].Id;
                
                this.handleShowTotalPayment();
                this.handleRecentPaymentDate();
                this.handlePaymentByContact();
                
            }
        }
    }
    handlePaymentByContact() {        
        getPaymentByContact({ concatId: this.selectedId })
            .then(result => {
                this.payments =null;                
                this.payments = result;
               
            })
            .catch(error => {
                this.error = error;
            });
    }
    handleShowTotalPayment() {      
        getShowTotalPayment({ concatId: this.selectedId })
            .then(result => {
                this.totalPaymentAmount = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    handleRecentPaymentDate() {       
        getRecentPaymentDate({ concatId: this.selectedId })
            .then(result => {
                this.mostRecentPaymentDate = result;
            })
            .catch(error => {
                this.error = error;
            });
    }
    handleSave1(event) {
        this.saveDraftValues1 = event.detail.draftValues;
        const recordInputs = this.saveDraftValues1.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        // Updateing the records using the UiRecordAPi
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.saveDraftValues1 = [];
            return this.refresh();
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.saveDraftValues1 = [];
        });
    }
    handleSave(event) {
        this.saveDraftValues = event.detail.draftValues;
        const recordInputs = this.saveDraftValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });

        // Updateing the records using the UiRecordAPi
        const promises = recordInputs.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            this.saveDraftValues = [];
            return this.refresh();
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'An Error Occured!!',
                    variant: 'error'
                })
            );
        }).finally(() => {
            this.saveDraftValues = [];
        });
    }
    showNotification() {
        const event = new ShowToastEvent({
            title: 'Error',
            message: 'Only one row can be selected',
            variant: 'warning',
            mode: 'pester'
        });
        this.dispatchEvent(event);
    }
    // This function is used to refresh the table once data updated
    async refresh() {
        await refreshApex(this.contacts);
    }
}