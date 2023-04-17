public class OpportunityAmountAutomate {
    public static void amountAutomateIns(List<Opportunity> TriggerNew)
    {
        List<Opportunity> oppList = new List<Opportunity>();
        Decimal oppAmount;
        Integer startMonth;
        Integer endMonth;
        String nameOfendDtMonth;
        String nameOfstartDtMonth;
        Date StartDate;
        Date endDate;
        Integer startDt_year;
        Integer Current_year;
        Integer endDt_year;
        Integer Next_year;
        
        For(Opportunity newOp : TriggerNew)
        {
            StartDate = newOp.Start_Date__c ;
            startDt_year = StartDate.year(); // get the year of start date
            startMonth = StartDate.month();  // get the month of start date
            Integer d = StartDate.day();     // get the day of start date
            DateTime dt = DateTime.newInstance(startDt_year,startMonth,d);
            System.debug(dt.format('MMMM')); // Will print the name of the month
            nameOfstartDtMonth = dt.format('MMMM');
            System.debug('@@@ nameOfstartDtMonth'+nameOfstartDtMonth); // Will print the name of the month
            endDate = newOp.End_Date__c;
            endDt_year = endDate.year(); // get the year of the end date
            endMonth = endDate.month(); // get the month of the end date
            Integer ed = endDate.day(); // get the day of the end date 
            DateTime endDt = DateTime.newInstance(endDt_year,endMonth,ed);
            System.debug(endDt.format('MMMM'));
            nameOfendDtMonth =endDt.format('MMMM'); 
            OppAmount = newOp.Amount;
            
            // Checking the Current year cases with Start and end date        
            if(newOp.Current_Year__c!=null)
            {
                
                Current_year = integer.valueOf(newOp.Current_Year__c); 
                
           // To check the Current year should be greater than start date and less than the end date year    
                if(Current_year > startDt_year && Current_year <= endDt_year)
                {
                    system.debug('picklist of current year is '+Current_year);
                    system.debug('### startDt_year is '+startDt_year);
                    system.debug('### endDt_year is '+endDt_year);
                    system.debug('### opp Amount is '+OppAmount);
                    newOp.Current_Year_Jan__c=OppAmount;
                    newOp.Current_Year_Feb__c=OppAmount;
                    newOp.Current_Year_Mar__c=OppAmount;
                    newOp.Current_Year_Apr__c=OppAmount;
                    newOp.Current_Year_May__c=OppAmount;
                    newOp.Current_Year_June__c=OppAmount;
                    newOp.Current_Year_July__c=OppAmount;
                    newOp.Current_Year_Aug__c=OppAmount;
                    newOp.Current_Year_Sep__c=OppAmount;
                    newOp.Current_Year_Oct__c=OppAmount;
                    newOp.Current_Year_Nov__c=OppAmount;
                    newOp.Current_Year_Dec__c=OppAmount; 
                } 
                
                // To check the Current year should be equal to the start date        
                
                if( Current_year == startDt_year && StartDate!=null )
                {
                    system.debug('@@@ current year is '+Current_year);
                    if( nameOfstartDtMonth =='January')
                    {
                        system.debug('@@@ name of month is '+nameOfstartDtMonth);
                        newOp.Current_Year_Jan__c=OppAmount;
                        newOp.Current_Year_Feb__c=OppAmount;
                        newOp.Current_Year_Mar__c=OppAmount;
                        newOp.Current_Year_Apr__c=OppAmount;
                        newOp.Current_Year_May__c=OppAmount;
                        newOp.Current_Year_June__c=OppAmount;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;
                    }
                    
                    else if(nameOfstartDtMonth == 'February')  
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=OppAmount;
                        newOp.Current_Year_Mar__c=OppAmount;
                        newOp.Current_Year_Apr__c=OppAmount;
                        newOp.Current_Year_May__c=OppAmount;
                        newOp.Current_Year_June__c=OppAmount;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;  
                    }
                    else if(nameOfstartDtMonth == 'March') 
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=OppAmount;
                        newOp.Current_Year_Apr__c=OppAmount;
                        newOp.Current_Year_May__c=OppAmount;
                        newOp.Current_Year_June__c=OppAmount;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;  
                        
                    }
                    else if(nameOfstartDtMonth == 'April' )
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=OppAmount;
                        newOp.Current_Year_May__c=OppAmount;
                        newOp.Current_Year_June__c=OppAmount;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }
                    else if(nameOfstartDtMonth == 'May')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=OppAmount;
                        newOp.Current_Year_June__c=OppAmount;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'June')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=OppAmount;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'July')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=null;
                        newOp.Current_Year_July__c=OppAmount;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'August')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=null;
                        newOp.Current_Year_July__c=null;
                        newOp.Current_Year_Aug__c=OppAmount;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'September')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=null;
                        newOp.Current_Year_July__c=null;
                        newOp.Current_Year_Aug__c=null;
                        newOp.Current_Year_Sep__c=OppAmount;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'October')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=null;
                        newOp.Current_Year_July__c=null;
                        newOp.Current_Year_Aug__c=null;
                        newOp.Current_Year_Sep__c=null;
                        newOp.Current_Year_Oct__c=OppAmount;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'November')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=null;
                        newOp.Current_Year_July__c=null;
                        newOp.Current_Year_Aug__c=null;
                        newOp.Current_Year_Sep__c=null;
                        newOp.Current_Year_Oct__c=null;
                        newOp.Current_Year_Nov__c=OppAmount;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    }  
                    else if(nameOfstartDtMonth == 'December')
                    {
                        newOp.Current_Year_Jan__c=null;
                        newOp.Current_Year_Feb__c=null;
                        newOp.Current_Year_Mar__c=null;
                        newOp.Current_Year_Apr__c=null;
                        newOp.Current_Year_May__c=null;
                        newOp.Current_Year_June__c=null;
                        newOp.Current_Year_July__c=null;
                        newOp.Current_Year_Aug__c=null;
                        newOp.Current_Year_Sep__c=null;
                        newOp.Current_Year_Oct__c=null;
                        newOp.Current_Year_Nov__c=null;
                        newOp.Current_Year_Dec__c=OppAmount;     
                    } 
                    
                }
                
      // Updated as null if Current year is less than the start and end date year
                
                else if(Current_year < startDt_year || Current_year > endDt_year)
                {
                    
                    newOp.Current_Year_Jan__c=null;
                    newOp.Current_Year_Feb__c=null;
                    newOp.Current_Year_Mar__c=null;
                    newOp.Current_Year_Apr__c=null;
                    newOp.Current_Year_May__c=null;
                    newOp.Current_Year_June__c=null;
                    newOp.Current_Year_July__c=null;
                    newOp.Current_Year_Aug__c=null;
                    newOp.Current_Year_Sep__c=null;
                    newOp.Current_Year_Oct__c=null;
                    newOp.Current_Year_Nov__c=null;
                    newOp.Current_Year_Dec__c=null;   
                    system.debug('%% current year jan' + newOp.Current_Year_Jan__c);
                    system.debug('%% current year jan' + newOp.Current_Year_Feb__c);
                    system.debug('%% current year jan' + newOp.Current_Year_Mar__c);
                    system.debug('%% current year jan' + newOp.Current_Year_Apr__c);
                    system.debug('%% current year jan' + newOp.Current_Year_May__c); 
                    system.debug('%% current year jan' + newOp.Current_Year_June__c);
                    system.debug('%% current year jan' + newOp.Current_Year_July__c);
                    system.debug('%% current year jan' + newOp.Current_Year_Aug__c);
                    system.debug('%% current year jan' + newOp.Current_Year_Sep__c);
                }
            }
            
     // Updated as null if Current year picklist field is left as null
            
            else if(Current_year == null)
            {
                newOp.Current_Year_Jan__c=null;
                newOp.Current_Year_Feb__c=null;
                newOp.Current_Year_Mar__c=null;
                newOp.Current_Year_Apr__c=null;
                newOp.Current_Year_May__c=null;
                newOp.Current_Year_June__c=null;
                newOp.Current_Year_July__c=null;
                newOp.Current_Year_Aug__c=null;
                newOp.Current_Year_Sep__c=null;
                newOp.Current_Year_Oct__c=null;
                newOp.Current_Year_Nov__c=null;
                newOp.Current_Year_Dec__c=null;   
                
            }
            
   // checking the Next Year cases    
            
            if(newOp.Next_Year__c!=null)
            {
                Next_year = integer.valueOf(newOp.Next_Year__c);
                // To check the next year is less than the end date year 
                
                if(Next_year < endDt_year && Next_year > startDt_year)
                {
                    system.debug('@@@ next year is  '+Next_year);
                    system.debug('@@@ end date is  '+endDt_year);
                    newOp.Next_Year_Jan__c=OppAmount;
                    newOp.Next_Year_Feb__c=OppAmount;
                    newOp.Next_Year_Mar__c=OppAmount;
                    newOp.Next_Year_Apr__c=OppAmount;
                    newOp.Next_Year_May__c=OppAmount;
                    newOp.Next_Year_June__c=OppAmount;
                    newOp.Next_Year_July__c=OppAmount;
                    newOp.Next_Year_Aug__c=OppAmount;
                    newOp.Next_Year_Sep__c=OppAmount;
                    newOp.Next_Year_Oct__c=OppAmount;
                    newOp.Next_Year_Nov__c=OppAmount;
                    newOp.Next_Year_Dec__c=OppAmount; 
                }
                
  // To check the Next year is same as the end date year
                
                if(Next_year == endDt_year && newOp.End_Date__c!=null)
                {
                    system.debug('@@@ next year is  '+Next_year);
                    system.debug('@@@ end date year is'+endDt_year);
                    
                    if(nameOfendDtMonth == 'January')
                    {
                        newOp.Next_Year_Jan__c=OppAmount;
                        system.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=null;
                        newOp.Next_Year_Mar__c=null;
                        newOp.Next_Year_Apr__c=null;
                        newOp.Next_Year_May__c=null;
                        newOp.Next_Year_June__c=null;
                        newOp.Next_Year_July__c=null;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                    }
                    else if(nameOfendDtMonth == 'February')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=null;
                        newOp.Next_Year_Apr__c=null;
                        newOp.Next_Year_May__c=null;
                        newOp.Next_Year_June__c=null;
                        newOp.Next_Year_July__c=null;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                    }
                    else if(nameOfendDtMonth  == 'March')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=null;
                        newOp.Next_Year_May__c=null;
                        newOp.Next_Year_June__c=null;
                        newOp.Next_Year_July__c=null;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                    }
                    else if(nameOfendDtMonth == 'April')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=null;
                        newOp.Next_Year_June__c=null;
                        newOp.Next_Year_July__c=null;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                    }
                    else if(nameOfendDtMonth == 'May')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=null;
                        newOp.Next_Year_July__c=null;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                        
                    }
                    else if(nameOfendDtMonth =='June')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=null;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                    }
                    else if( nameOfendDtMonth == 'July')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=OppAmount;
                        newOp.Next_Year_Aug__c=null;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                        
                    }
                    else if(nameOfendDtMonth == 'August')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=OppAmount;
                        newOp.Next_Year_Aug__c=OppAmount;
                        newOp.Next_Year_Sep__c=null;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                        
                        
                    }
                    else if(nameOfendDtMonth == 'September')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=OppAmount;
                        newOp.Next_Year_Aug__c=OppAmount;
                        newOp.Next_Year_Sep__c=OppAmount;
                        newOp.Next_Year_Oct__c=null;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                        
                    }
                    else if(nameOfendDtMonth == 'October')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=OppAmount;
                        newOp.Next_Year_Aug__c=OppAmount;
                        newOp.Next_Year_Sep__c=OppAmount;
                        newOp.Next_Year_Oct__c=OppAmount;
                        newOp.Next_Year_Nov__c=null;
                        newOp.Next_Year_Dec__c=null;
                        
                    }
                    else if(nameOfendDtMonth == 'November')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=OppAmount;
                        newOp.Next_Year_Aug__c=OppAmount;
                        newOp.Next_Year_Sep__c=OppAmount;
                        newOp.Next_Year_Oct__c=OppAmount;
                        newOp.Next_Year_Nov__c=OppAmount;
                        newOp.Next_Year_Dec__c=null;
                    }
                    else if(nameOfendDtMonth == 'December')
                    {
                        newOp.Next_Year_Jan__c = OppAmount;
                        System.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                        newOp.Next_Year_Feb__c=OppAmount;
                        System.debug('@@@ next year Feb month update with the opp amount  '+newOp.Next_Year_Feb__c);
                        newOp.Next_Year_Mar__c=OppAmount;
                        newOp.Next_Year_Apr__c=OppAmount;
                        newOp.Next_Year_May__c=OppAmount;
                        newOp.Next_Year_June__c=OppAmount;
                        newOp.Next_Year_July__c=OppAmount;
                        newOp.Next_Year_Aug__c=OppAmount;
                        newOp.Next_Year_Sep__c=OppAmount;
                        newOp.Next_Year_Oct__c=OppAmount;
                        newOp.Next_Year_Nov__c=OppAmount;
                        newOp.Next_Year_Dec__c=OppAmount;
                    }
                }
                else  if(Next_year > endDt_year)
                {
                    newOp.Next_Year_Jan__c=null;
                    system.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                    newOp.Next_Year_Feb__c=null;
                    newOp.Next_Year_Mar__c=null;
                    newOp.Next_Year_Apr__c=null;
                    newOp.Next_Year_May__c=null;
                    newOp.Next_Year_June__c=null;
                    newOp.Next_Year_July__c=null;
                    newOp.Next_Year_Aug__c=null;
                    newOp.Next_Year_Sep__c=null;
                    newOp.Next_Year_Oct__c=null;
                    newOp.Next_Year_Nov__c=null;
                    newOp.Next_Year_Dec__c=null;
                }
            }
            
        // Updated as null if Next year picklist field is left as null
            
            else if(Next_year ==null)
            {
                newOp.Next_Year_Jan__c=null;
                system.debug('@@@ next year jan month update with the opp amount  '+newOp.Next_Year_Jan__c);
                newOp.Next_Year_Feb__c=null;
                newOp.Next_Year_Mar__c=null;
                newOp.Next_Year_Apr__c=null;
                newOp.Next_Year_May__c=null;
                newOp.Next_Year_June__c=null;
                newOp.Next_Year_July__c=null;
                newOp.Next_Year_Aug__c=null;
                newOp.Next_Year_Sep__c=null;
                newOp.Next_Year_Oct__c=null;
                newOp.Next_Year_Nov__c=null;
                newOp.Next_Year_Dec__c=null;
            }
            system.debug('newOp is '+newOp);
            system.debug('opp start date is '+StartDate);
            system.debug('opp start date year is '+startDt_year);
            system.debug('opp end date  is '+endDate);
            system.debug('opp end date year is '+endDt_year);
            
            system.debug('opp start date year is '+StartDate);
            system.debug('opp Amount  is '+ OppAmount);
            system.debug('@@@ nameOfstartDtMonth  is '+ nameOfstartDtMonth);
            system.debug('@@@ nameOfendDtMonth  is '+ nameOfendDtMonth);
            
        }
    }
}