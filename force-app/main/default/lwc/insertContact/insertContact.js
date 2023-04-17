import { LightningElement,track } from 'lwc';
import fetchData from '@salesforce/apex/createContactController.contactInsert';
import fetchAccount from'@salesforce/apex/createContactController.AccountFetch';

export default class InsertContact extends LightningElement {
    @track acc;
@track lName;
@track accId;
 message;
handleNameChange(event) {
    this.lName=event.target.value;
    console.log('Name',this.lName);

}
    connectedCallback(){
        fetchAccount()
        .then(result => {
        this.acc = result;
        
        console.log(JSON.stringify(result));
        console.log("result",this.acc);
        })
       
    }    
    AccountIdFetch(event){
        this.accId=event.target.value;
        console.log('accId',  this.accId);

    }

    forSubmit(event){
        fetchData({conObj :this.lName ,accountId : this.accId })
        .then(result => {
        this.message = result;
        
        console.log(JSON.stringify(result));
        console.log("result",this.message);
        })
        .catch(error => {
            this.error = error.message;
        });
    }
    

}