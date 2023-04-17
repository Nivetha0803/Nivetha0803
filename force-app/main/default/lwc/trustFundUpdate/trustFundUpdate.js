import { LightningElement,wire,api,track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getTrustFundList from '@salesforce/apex/trustFundController.getTrustFundList';
import createTrustFund from '@salesforce/apex/trustFundController.createTrustFund';
import Trust_Fund_Tracker__OBJECT from '@salesforce/schema/Trust_Fund_Tracker__c';
import TRACKER_MONTH_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_month__c';
import TRACKER_HSG_TYPE_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_hsg_type__c';
import TRACKER_YEAR_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_year__c';
import TRACKER_HOURS_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_hours__c';
import TRACKER_MONTHLY_GROSS_WAGES_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_monthly_gross_wages__c';
let FIELDS=['Trust_Fund_Tracker__c.tracker_month__c','Trust_Fund_Tracker__c.tracker_hsg_type__c','Trust_Fund_Tracker__c.tracker_year__c','Trust_Fund_Tracker__c.tracker_hours__c','Trust_Fund_Tracker__c.tracker_monthly_gross_wages__c'];
export default class TrustFundUpdate extends LightningElement {
    @api objectApiName =  Trust_Fund_Tracker__OBJECT;
    @api recordId;
    @track year; //declared class level variable
    @track month;
     @track hsgType;
     @track grossWages;
     @track hours;
     @track reportOptions=[];
     @track saveMode = false;
     @track editMode = true;
     @track trustFundList;
     @track error;
    
 /*  @track trustFund;
   @wire(getRecord, { recordId: '$recordId', fields: [ ACCOUNT_ID ] })
   account;

   @wire(getContacts, { accountId: this.accountId() })
   contacts({ error, data }) {
       if (data) {
           this.foundContacts = data;
           this.error = undefined;
       }
       else {
           this.error = error;
           this.foundContacts = undefined;
       }
   }*/
     
   /* @wire (getTrustFundList, {hsgType:'this.hsgType()'})
     
     
     get month()
     {
         return this.trustFund.data ? getFieldValue(this.trustFund.data,TRACKER_MONTH_FIELD) :'';
                 return this.meeting.data ? getSObjectValue(this.meeting.data, ID_FIELD) : '';

     }
     get HSGType()
     {
         return getFieldValue(this.trustFund.data,TRACKER_HSG_TYPE_FIELD)
     }
      
     get grossWages()
     {
         return getFieldValue(this.trustFund.data,TRACKER_MONTHLY_GROSS_WAGES_FIELD)
     }
     get year()
     {
         return getFieldValue(this.trustFund.data, TRACKER_YEAR_FIELD)
     }
 
     get hours()
     {
         return getFieldValue(this.trustFund.data,TRACKER_HOURS_FIELD)
     }*/

     handleCancel(event) {
        this.editMode=true;
        this.saveMode=false;
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }

    handleChange(event){
        const{name,value} = event.target
        
    if(name=="hsgType")
    {
        this.hsgType=value;
    }
    if(name=="year")
    {
        this.year=value;
    }
    if(name=="month")
    {
        this.month=value;
    }
    if(name=="grossWages")
    {
        this.grossWages=value;
    }
    if(name=="grossWages")
    {
        this.hours=value;
    }
    }
    get options() {
        return [
            { label: 'Dietary', value: 'dietary' },
            { label: 'Housekeeping', value: 'housekeeping' },
            { label: 'Janitorial', value: 'janitorial' },
            { label: 'Laundry', value: 'laundry' },
            { label: 'Not Specified	', value: 'Not Specified' },
        ];
    }

    get values()
    {
        return[
            { label:'January',value:'january'},
            { label:'February',value:'february'},
            { label:'March',value:'march'},
            { label:'April',value:'april'},
            { label:'May',value:'may'},
            { label:'June',value:'june'},
            { label:'July',value:'july'},
            { label:'August',value:'august'},
            { label:'September',value:'september'},
            { label:'October',value:'october'},
            { label:'November',value:'november'},
            { label:'December',value:'december'},
];
    }


 saveRecord(event)
    {
        createTrustFund({hsgType: this.hsgType,year:this.year,month:this.month,grossWages:this.grossWages,hoursReported:this.hoursReported})
        .then(response=>{
            console.log(response)
            this.dispatchEvent(new ShowToastEvent({
                title : 'Insert Record',
                message : 'Record Id' + response,
                variant : 'Success'
        
        }) )
    })
        .catch(error=>{
            console.log(error)
            this.dispatchEvent(new ShowToastEvent({
                title : 'Insert Record',
                message : 'Unable to create record',
                variant : 'error'
            }))
        })
       
    }
   /* saveRecord(event) {
        this.saveMode=true;
        this.editMode=false;
        this.recordId = event.detail.id;
        console.log(this.recordId);
        
        this.recordId=event.detail.id;
        this.hsgType=event.target.value;
        this.month=event.target.value;
        this.year=event.target.value;
        
        console.log( this.recordId)
       getTrustFundList({recordId: this.recordId,hsgType: this.hsgType,year:this.year,month:this.month})
       .then(response=>{
        console.log(response)
        alert(response)
        this.trustFundList = response;
    alert(this.trustFundList );
      

    })
       .catch(error=>{
 this.trustFundList = error;
       });
   
    }*/
    
    
    editRecord(event) 
    {
        console.log("+event"+event.detail);
        this.editMode=true;
        this.saveMode=false;
       getTrustFundList({recordId: this.recordId,hsgType: this.hsgType,year:this.year,month:this.month})
       .then(response=>{
        console.log(response)
        alert(response)
        this.trustFundList = response;
    alert(this.trustFundList );
      

    })
        
       .catch(error=>{

    });

    }


    getChange(event)
    {
        /*this.saveMode=true;
        this.editMode=false;*/
        this.recordId=event.detail.id;
        this.hsgType=event.target.value;
        this.month=event.target.value;
        this.year=event.target.value;
        this.reportOptions=[];
        console.log( this.recordId)
       getTrustFundList({hsgType: this.hsgType,year:this.year,month:this.month})
       .then(response=>{
        console.log(response)
        this.trustFundList = response;

       for(var i =0;i<response.length;i++)
       {
           if(hsgType==this.trustFundList[i].id && month==this.trustFundList[i].id && year==this.trustFundList[i].id )
           {
               this.grossWages = this.trustFundList[i].grossWages;
               this.hoursReported = this.trustFundList[i].hoursReported;
           }
              
           
           this.trustFundList=[...this.trustFundList,1];
       }

    })
       .catch(error=>{

       });
   
    }

}