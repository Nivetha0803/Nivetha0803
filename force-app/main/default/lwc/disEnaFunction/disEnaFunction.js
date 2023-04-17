import { LightningElement,track } from 'lwc';

export default class DisEnaFunction extends LightningElement {
    @track inputvalue;
    @track Buttontrue=true;
    handleChange(event){
        this.inputvalue = event.target.value;
        console.log('++++',this.inputvalue);
        if(this.inputvalue > 0){
            this.Buttontrue=false;
        }
    }
}