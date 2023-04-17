import { LightningElement, api, track} from 'lwc';
import CLAIM_OBJECT from '@salesforce/schema/Claims__c';
import insertClaimMethod from '@salesforce/apex/InsertClaimController.insertClaimMethod';
import loadClaimRecords from '@salesforce/apex/InsertClaimController.OnLoadClaimRecords';
import fetchClaimRecords from '@salesforce/apex/InsertClaimController.fetchClaimRecords';

import ATU_LOGO from '@salesforce/resourceUrl/ATU_Logo';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateClaim extends NavigationMixin(LightningElement){

  activeSections = ['A', 'B'];
  ATULogo = ATU_LOGO;
   
    @track MemberData;
    @api recordId;
    @api objectApiName = CLAIM_OBJECT;
   
    @track claimId;
     onselect='';

     @track benefitType;
     @track member;
     @track claimsts;
     @track memRegion;
     @track bankAcc;
     @track checkAmt;
     @track deathCert;
     @track claimRecvd;
     @track funBill;
     @track addBills;
     @track sign;
     @track locUnion;

    


     @api BenefitType_Ref;
     @api Claimsts_Ref;
     @api MemRegion_Ref;
     @api AddBills_Ref;
     @api BankAcc_Ref;
     @api CheckAmt_Ref;
     @api FunBill_Ref;
     @api Sign_Ref;
     @api OnLoad_Ref;
     @api FromDate_Ref;
     @api ToDate_Ref;
     @track isShowModal = false;
     @track isOpenModal = false;
     claimList;


  // Fields stored in arraylist
  /*  @track FieldList={benefitType:BENEFIT_TYPE_FIELD, claimSts : CLAIM_STATUS_FIELD, MemFullName : MEMBER_FULLNAME_FIELD,
        MemRegion : MEMBER_REGION_FIELD, bankAcc : BANK_ACCOUNT_FIELD, checkAmt : CHECK_AMOUNT_FIELD, deathCert : DEATHCERT_FIELD,
        claimRecvd : CLAIMRECD_FIELD, FunBill : FUNBILL_FIELD, addBills : ADD_BILLS_FIELD, signature : SIGN_FIELD, localUnion : LOCAL_UNION_FIELD};
 */


        BenefitChange(event){
          this.BenefitType_Ref = event.detail.value;
         
          console.log("member full name",this.benefitType);
         
      }

      ClaimstsChange(event){
        this.Claimsts_Ref = event.detail.value;
        }
      MemNameChange(event){
      this.rec.member  = event.target.value;
        }
      MemRegChange(event){
      this.MemRegion_Ref  = event.detail.value;
      console.log('event value',this.MemRegion_Ref);

      // AutoPopulate Field value based on Member country values
      if(event.target.value == 'USA')
       {
        this.bankAcc = 'Citibank';
        this.onselect = 'True';
        console.log('event value',event.target.value);
        console.log('bank value',this.bankAcc);
      }
     
      else if(event.target.value == 'Canada')
      {
       this.bankAcc = 'Bank Of Montreal';
       this.onselect = 'false';
       console.log('event value2',event.target.value);
       console.log('bank value',this.bankAcc);
      }

      else if(event.target.value == '')
      {
       this.bankAcc = '';
       this.onselect = '';
       console.log('event value2',event.target.value);
       console.log('bank value',this.bankAcc);
      }
  }

 
BankAccChange(event){
  this.BankAcc_Ref  = event.detail.value;
  }
CheckAmtChange(event){
  this.CheckAmt_Ref  = event.detail.value;
  }
DeathCertChange(event){
  this.rec.deathCert  = event.target.value;
  }
ClaimRecvdChange(event){
  this.rec.claimRecvd  = event.target.value;
  }

  FunBillChange(event){
    this.FunBill_Ref  = event.detail.value;
    }
AddBillsChange(event){
  this.AddBills_Ref  = event.detail.value;
  }
SignChange(event){
    this.Sign_Ref  = event.detail.value;
    }
LocalUnionChange(event){
      this.rec.locUnion  = event.target.value;
      }





      

saveClaimAction(){
  window.console.log('before save '+ this.insertClaimMethod);
  insertClaimMethod ({benefitType : this.BenefitType_Ref, Claimsts: this.Claimsts_Ref, 
    MemRegion: this.MemRegion_Ref,AddBills:this.AddBills_Ref, Sign: this.Sign_Ref,FunBills: this.FunBill_Ref, BankAcc: this.BankAcc_Ref, CheckAmt:this.CheckAmt_Ref})
  .then(result=>{
    console.log('result is '+result);
    console.log('result is '+this.rec);;
    this.claimId = result.Id;
    console.log('result is ',result);
    
  const event = new ShowToastEvent({
    title: 'Success',
    message:'Claim Record created has been successfully',
        variant: 'success',
});
this.dispatchEvent(event);


/*start navigation*/

this[NavigationMixin.Navigate]({
  type: 'standard__recordPage',
  attributes: {
    recordId: this.claimId,
    objectApiName: 'Claims__c',
    actionName: 'view'
  },
});


})

.catch(error=>{
  this.error = error.message;
  window.console.log(this.error);
})
}

saveNewAction(){
  window.console.log('eeee');
  insertClaimMethod({benefitType : this.BenefitType_Ref, Claimsts: this.Claimsts_Ref, 
    MemRegion: this.MemRegion_Ref,AddBills:this.AddBills_Ref, Sign: this.Sign_Ref,FunBills: this.FunBill_Ref, BankAcc: this.BankAcc_Ref, CheckAmt:this.CheckAmt_Ref})
.then(result=>{
  window.console.log('eeee '+result);
    this.claimId = result.Id;
    console.log('result is ',result);
    window.console.log('eeee' + this.claimId);
    const event = new ShowToastEvent({
      title: 'Success',
      message:'Claim Record created has been successfully',
          variant: 'success',
  });
  this.dispatchEvent(event);
  eval("$A.get('e.force:refreshView').fire();");

})
.catch(error=>{
  this.error = error.message;
  window.console.log(this.error);
})

  }


fetchRecords(){
  window.console.log('eeee');
  this.isShowModal = true;
  this.isOpenModal= false;
  fetchClaimRecords({fromDate: this.FromDate_Ref, toDate: this.ToDate_Ref})
  .then(_result=>{
    this.claimList = _result;
    console.log('result is ',_result);
    window.console.log('result is ',_result);
    window.console.log('eeee' + this.claimList);
    /*alert('View Recent Records '+ JSON.stringify(_result));
    alert('View Recent Records '+ this.claimList.length);
    alert('Selected from date is '+ this.FromDate_Ref);
    alert('Selected to date is '+ this.ToDate_Ref);*/
  })
  
}

getRecords(){
// alert('eee');
  this.isOpenModal= true;
  this.isShowModal = false;
  loadClaimRecords({onLoad:this.OnLoad_Ref,})
  .then(result=>{
    this.claimList = result;
    //alert(' from date'+this.FromDate_Ref);
    //alert(' to date'+this.ToDate_Ref);
    console.log('result is ',result);
    window.console.log('result is ',result);
    window.console.log('eeee' + this.claimList);
    /*alert('View Recent Records '+ JSON.stringify(result));
    alert('View Recent Records '+ this.claimList.length);
    alert('Selected from date is '+ this.FromDate_Ref);
    alert('Selected to date is '+ this.ToDate_Ref);*/
    
   
   
  })
  
}

handleFromDateChange(event){
    this.FromDate_Ref = event.detail.value;
    console.log('from date is '+this.FromDate_Ref);
}

handleToDateChange(event){
  this.ToDate_Ref = event.detail.value;
  console.log('to date is '+this.ToDate_Ref);
}
hideModalBox() {  
  this.isShowModal = false;
  this.isOpenModal= false;
  eval("$A.get('e.force:refreshView').fire();");

}






  /*handleRecordSave(){
    const event = new ShowToastEvent({
      title: 'Success',
      message:'Claim Record created has been successfully',
          variant: 'success',
  });
  this.dispatchEvent(event);
  }*/

  
      handleSuccess(event) {
        
        this.recordId = event.detail.id;
       
          
        
      }

      handleCancel(event){
     // var url = window.location.href; 
      window.history.back();
     // return false;
  }
      
      }