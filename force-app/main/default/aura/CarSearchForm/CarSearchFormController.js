({
    doInit: function(component,event,helper){
        debugger;
        
        var createCarRecord=$A.get("e.force:createRecord");
        if(createCarRecord){
            component.set("v.showNew",true);
        }else{
            component.set("v.showNew",false);
        }
        
        helper.getCarType(component,event,helper);
},
    
	onSearchClick : function(component, event, helper) {
		helper.handleOnSearch(component, event, helper);
	},


   
    newValueSelected : function(component, event, helper) {
    var currentValue = component.find("carTypeList").get("!v.value");
       alert(carTypeId+' option selected');
        
},
   
    createCarRecord : function(component, event, helper) {
         var createCarRecord=$A.get("e.force:createRecord");
    
        createCarRecord.setParams({
            "entityApiName" : "Car_Type__c"
        });
         createCarRecord.fire();                         
    },
})