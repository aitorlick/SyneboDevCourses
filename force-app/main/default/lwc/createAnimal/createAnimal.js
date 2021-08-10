import { LightningElement, track } from 'lwc';
import ANIMAL_OBJECT from '@salesforce/schema/Animal__c';
import NAME_FIELD from '@salesforce/schema/Animal__c.Name';
import EXTERNAL_ID_FIELD from '@salesforce/schema/Animal__c.External_Id__c';
import EATS_FIELD from '@salesforce/schema/Animal__c.Eats__c';
import SAYS_FIELD from '@salesforce/schema/Animal__c.Says__c';
import createAnimalServer from '@salesforce/apex/AnimalController.createAnimal';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class createAnimal extends LightningElement {

    @track isModalOpen = false;
    @track updateAnimalWithoutQuestions = false;

    @track name = NAME_FIELD;
    @track externalId = EXTERNAL_ID_FIELD;
    @track eats = EATS_FIELD;
    @track says = SAYS_FIELD;
    rec = {
        Name : this.name,
        External_Id__c : this.externalId,
        Eats__c : this.eats,
        Says__c : this.says
    }

    closeModal() {
        this.isModalOpen = false;

        this.rec.Name = '';
        this.rec.External_Id__c = '';
        this.rec.Eats__c = '';
        this.rec.Says__c = '';
    }
    submitDetails() {
        this.isModalOpen = false;
        this.updateAnimalWithoutQuestions = true;
        this.handleClick();
    }

    changeAnimalIdHandler(event) {
        this.rec.Name = event.target.value;
    }
    changeExternalIdHandler(event) {
        this.rec.External_Id__c = event.target.value;
    }
    changeEatsHandler(event) {
        this.rec.Eats__c = event.target.value;
    }
    changeSaysHandler(event) {
        this.rec.Says__c = event.target.value;
    }
    handleClick() {
        console.log(this.rec);
        createAnimalServer({ animal : this.rec, updateAnimalWithoutQuestions : this.updateAnimalWithoutQuestions})
            .then(result => {
                this.message = result;
                this.error = undefined;
                if(this.message !== undefined) {
                    
                    if(this.message === null) {
                        this.isModalOpen = true;
                    } else {
                        this.rec.Name = '';
                        this.rec.External_Id__c = '';
                        this.rec.Eats__c = '';
                        this.rec.Says__c = '';
                        
                        if(this.updateAnimalWithoutQuestions === true) {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Success',
                                    message: 'Animal updated',
                                    variant: 'success',
                                }),
                            );
                        } else {
                            this.dispatchEvent(
                                new ShowToastEvent({
                                    title: 'Success',
                                    message: 'Animal created',
                                    variant: 'success',
                                }),
                            );
                        }
                        
                        this.updateAnimalWithoutQuestions = false;
                    }
        
                }
                
                console.log(JSON.stringify(result));
                console.log("result", this.message);
            })
            .catch(error => {
                this.message = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating / updating record',
                        message: error.body.message,
                        variant: 'error',
                    }),
                );
                console.log("error", JSON.stringify(this.error));
            });
    }

}