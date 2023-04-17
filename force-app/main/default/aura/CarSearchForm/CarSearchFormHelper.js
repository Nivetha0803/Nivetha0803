({
	handleOnSearch : function(component, event, helper) {
		alert('Search Button was clicked');
	},
    
    getCarType : function(component, event){
    var action = component.get("c.getCarTypes");
        action.setCallback(this,function(data){
           
       if(state == "SUCCESS"){
            component.set("v.carTypes",data.getReturnValue());
        }else if(state === "error")
        {
            alert('unknown error');
        } 
        });
       $A.enqueueAction(action); 
}
})