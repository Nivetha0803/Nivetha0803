import { LightningElement,track } from 'lwc';
import Id from '@salesforce/user/Id';
export default class UserInformation extends LightningElement {
    userId = Id;
    @track saveMode = true;
    @track editMode = false;


    editRecord(event) {
        console.log("+event"+event.detail);
        this.editMode=true;
        this.saveMode=false;
        //this.contactId = event.detail.id;
        console.log(this.userId);
        alert(this.editMode);
        console.log(this.userId);
    }
    saveRecord(event) {
        this.saveMode=true;
        this.editMode=false;
        this.userId = event.detail.id;
        console.log(this.userId);
        alert(this.userId);
    }


        handleCancel(event) {
            this.editMode=true;
            this.saveMode=false;
            event.preventDefault();
            const inputFields = this.template.querySelectorAll(
                'lightning-input-field'
            );
            if (inputFields) {
                inputFields.forEach(field => {
                    field.reset();
                });
            
            }
        }
}