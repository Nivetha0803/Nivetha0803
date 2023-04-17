import { LightningElement,api ,track, wire} from 'lwc';
import { getSObjectValue } from '@salesforce/apex';
import getTrustFundList from '@salesforce/apex/getTrustFundController.getTrustFundList';
import getTrackerRecord from '@salesforce/apex/getTrustFundController.getTrackerRecord';

import Trust_Fund_Tracker__c from '@salesforce/schema/Trust_Fund_Tracker__c';
import TRACKER_MONTHLY_GROSS_WAGES_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_monthly_gross_wages__c';
import TRACKER_HOURS_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_hours__c';
import TRACKER_HSG_TYPE_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_hsg_type__c';
import TRACKER_YEAR_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_year__c';
import TRACKER_MONTH_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_month__c';

export default class ApexGetTrustFund extends LightningElement {
    @track trustFundList
    @track hsgType
    @track month
    @track year
    @track error
  /*  @track columns=[{label:'HSG Type' ,FieldName:'tracker_hsg_type__c',type:'text'},
{label:'Year' ,FieldName:'tracker_year__c',type:'text'},
{label:'Month' ,FieldName:'tracker_month__c',type:'Number'},
{label:'Hours' ,FieldName:'tracker_hours__c',type:'Number'}];*/
    handleClick(event)
    {
              
        getTrustFundList({hsgType:'Laundry',month:'January',year:'2021',hours:'2',grossWages:'20000'})
        .then(response=>{
         console.log(response)
         this.trustFundList=response;
        }  )
        .catch(error=>{

        })
    }
    
  /*  @wire(getTrustFundList,{}) 

    get grossWages() {
        return this.trustFund.data ? getSObjectValue(this.trustFund.data, TRACKER_MONTHLY_GROSS_WAGES_FIELD) : '';
    }
    get hsgType() {
        return this.trustFund.data ? getSObjectValue(this.trustFund.data, TRACKER_HSG_TYPE_FIELD) : '';
    }
    get hours() {
        return this.trustFund.data ? getSObjectValue(this.trustFund.data, TRACKER_HOURS_FIELD) : '';
    }
    get month() {
        return this.trustFund.data ? getSObjectValue(this.trustFund.data, TRACKER_MONTH_FIELD) : '';
    }
    get year() {
        return this.trustFund.data ? getSObjectValue(this.trustFund.data, TRACKER_YEAR_FIELD) : '';
 
    }*/



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
   

 /*   connectedCallback()
    {
        getTrackerRecord()
        
            .then(result=>{
                this.trustFundList=result;
            })
        .catch(error=>{
            this.trustFundList=error;
        })
    }*/
}