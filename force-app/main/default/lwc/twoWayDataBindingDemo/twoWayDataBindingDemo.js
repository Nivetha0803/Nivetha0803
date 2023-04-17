import { LightningElement,track } from 'lwc';

export default class TwoWayDataBindingDemo extends LightningElement {
    @track fullname="Nivetha Rajan";
    @track title="Salesforce Developer";
    changeHandler(event)
    {
        this.fullname=event.target.value;
        this.title=event.target.value;
    }
}