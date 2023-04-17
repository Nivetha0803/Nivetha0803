import { LightningElement,api ,track, wire} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import Trust_Fund_Tracker__c from '@salesforce/schema/Trust_Fund_Tracker__c';
import TRACKER_ACCOUNT_INACTIVE_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_account_inactive__c';
import AMOUNT_DUE_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.Amount_Due__c';
import TRACKER_AMOUNT_PAID_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_amount_paid__c';
import TRACKER_CHECK_AMOUNT_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_check_amount__c';
import TRACKER_CHECK_MULTI_MONTH_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_check_multi_month__c';
import TRACKER_CHECK_NUMBER_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_check_number__c';
import CONTRIBUTION_RATE_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.Contribution_Rate__c';
import TRACKER_DATE_PAYMENT_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_date_payment__c';
import TRACKER_DATE_REPORTS_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_date_reports__c';
import TRACKER_RETRO_DATE_PAYMENT_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_retro_date_payment__c';
import TRACKER_MONTH_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_month__c';
import TRACKER_RETRO_AMOUNT_PAID_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_retro_amount_paid__c';
import TRACKER_YEAR_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_year__c';
import TRACKER_RETRO_MONTH_END_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_retro_month_end__c';
import TRACKER_RETRO_MONTH_START_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_retro_month_start__c';
import FLAG_REPORT_RECEIVED_LATE_TEST_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.Flag_Report_Received_Late_Test__c';
import TRACKER_MONTHLY_GROSS_WAGES_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_monthly_gross_wages__c';
import TRACKER_HOURS_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_hours__c';
import TRACKER_HSG_TYPE_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_hsg_type__c';
import TRACKER_EES_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_ees__c';
import OVER_OR_UNDER_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.Over_or_Under__c';
import OVER_UNDER_BY_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.Over_Under_by__c';
import PREVIOUS_MONTH_NUMBER_OF_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.Previous_Month_Number_Of__c';
import TRACKER_REFUND_CHECK_AMOUNT_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_refund_check_amount__c';
import TRACKER_REFUND_CHECK_NUMBER_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_refund_check_number__c';
import TRACKER_REFUND_CHECK_REASON_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_refund_check_reason__c';
import TRACKER_RETRO_CHECK_AMOUNT_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_retro_check_amount__c';
import TRACKER_RETRO_CHECK_NUMBER_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_retro_check_number__c';
import NOTES_FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.tracker_notes__c';
import FACILITY_NAME__FIELD from '@salesforce/schema/Trust_Fund_Tracker__c.facility_name__c';




	








export default class TrustFundCreator extends LightningElement {
    @api objectApiName =  Trust_Fund_Tracker__c;
    @track activeSections = ['Information'];
    @api recordId;
     Year; //declared class level variable
     Month;
     HSGType;
  
    @track saveMode = true;


    /* Fields=[TRACKER_ACCOUNT_INACTIVE_FIELD,AMOUNT_DUE_FIELD, 
        CONTRIBUTION_RATE_FIELD ,TRACKER_AMOUNT_PAID_FIELD,TRACKER_RETRO_AMOUNT_PAID_FIELD,
        TRACKER_CHECK_MULTI_MONTH_FIELD ,TRACKER_CHECK_NUMBER_FIELD,
        TRACKER_CHECK_AMOUNT_FIELD,TRACKER_DATE_PAYMENT_FIELD,
        TRACKER_DATE_REPORTS_FIELD,TRACKER_RETRO_DATE_PAYMENT_FIELD,
        TRACKER_MONTH_FIELD,TRACKER_YEAR_FIELD,
        TRACKER_RETRO_MONTH_START_FIELD ,TRACKER_RETRO_MONTH_END_FIELD,
        FLAG_REPORT_RECEIVED_LATE_TEST_FIELD,TRACKER_MONTHLY_GROSS_WAGES_FIELD,
        TRACKER_HOURS_FIELD,TRACKER_HSG_TYPE_FIELD,TRACKER_EES_FIELD,OVER_OR_UNDER_FIELD,
        OVER_UNDER_BY_FIELD,PREVIOUS_MONTH_NUMBER_OF_FIELD,TRACKER_REFUND_CHECK_AMOUNT_FIELD,
        TRACKER_REFUND_CHECK_NUMBER_FIELD,TRACKER_REFUND_CHECK_REASON_FIELD,
        TRACKER_RETRO_CHECK_AMOUNT_FIELD,TRACKER_RETRO_CHECK_NUMBER_FIELD,NOTES_FIELD];*/
    
    
        handleSuccess(event) {
        const toastEvent = new ShowToastEvent({
            title: "Trust Fund Tracker record is created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(toastEvent);
        this.recordid = event.detail.id;
        console.log(this.recordId);

    }
  
    
    handleCancel(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }


    
    Trust_Fund_Tracker__c = [
        {
            label: "Information",
            fields: [
                TRACKER_ACCOUNT_INACTIVE_FIELD,AMOUNT_DUE_FIELD, 
        CONTRIBUTION_RATE_FIELD ,TRACKER_AMOUNT_PAID_FIELD,FACILITY_NAME__FIELD,
        TRACKER_CHECK_MULTI_MONTH_FIELD ,TRACKER_CHECK_NUMBER_FIELD,
        TRACKER_CHECK_AMOUNT_FIELD,TRACKER_DATE_PAYMENT_FIELD,
        TRACKER_DATE_REPORTS_FIELD,
        TRACKER_MONTH_FIELD,TRACKER_YEAR_FIELD,
        FLAG_REPORT_RECEIVED_LATE_TEST_FIELD,TRACKER_MONTHLY_GROSS_WAGES_FIELD,
        TRACKER_HOURS_FIELD,TRACKER_HSG_TYPE_FIELD,TRACKER_EES_FIELD,OVER_OR_UNDER_FIELD,
        OVER_UNDER_BY_FIELD,PREVIOUS_MONTH_NUMBER_OF_FIELD
    ]
        },
        {
            label: "Retro Payment Information",
            fields: [
                TRACKER_RETRO_DATE_PAYMENT_FIELD,
                TRACKER_RETRO_CHECK_AMOUNT_FIELD,
                TRACKER_RETRO_CHECK_NUMBER_FIELD,
                TRACKER_RETRO_MONTH_START_FIELD,
                TRACKER_RETRO_MONTH_END_FIELD,
                TRACKER_RETRO_AMOUNT_PAID_FIELD
            ]
            },
            {
                label: "Refund Information",
                fields: [
                    
                    TRACKER_REFUND_CHECK_NUMBER_FIELD,
                    TRACKER_REFUND_CHECK_AMOUNT_FIELD ,
                    TRACKER_REFUND_CHECK_REASON_FIELD
                    
                ]
                },
                
                {
                    label: "Notes",
                    fields: [
                      
                        NOTES_FIELD
                    ]
                    },
       
    ];


trustFundList; // data is stored in class level property called 'trustFundList'.getTrustFundList method gets the data from apex method and pass it to thr js class level variabe.

   /* @wire(getTrustFundList,{HSGType:'$HSGType',Month:'$Month',Year:'$Year'})
    trustFundHandler({data,error})
    {
if(data)
{
    console.log(data);
    this.trustFundList=data;

}
if(error)
{
    console.log(error);
}
    }*/

   /* saveRecord(event)
    {
        this.saveMode=true;
        trustFundList({HSGType:'$HSGType',Month:'$Month',Year:'$Year'})
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
       
    }*/

}