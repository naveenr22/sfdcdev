({

    handleComponentEvent: function(component, event, helper) {
    
        console.log('Entering into Handle Component :: ');
        var action = component.get("c.getAccounts");
        console.log('Action is : : = ' + action);
        var valuefromChild = event.getParam("message");
        component.set("v.enteredValue", valuefromChild);
        console.log("value from Child" + valuefromChild);
        
        action.setParams({
            "enteredkeyword": valuefromChild
        });
        
        action.setCallback(this, function(response) {
            var state = response.getState(); // get the response state
            if (state == "SUCCESS") {
                console.log('result is ' + JSON.stringify(response.getReturnValue()));
                component.set("v.sObjList", response.getReturnValue());
            }
            
        });
        
        $A.enqueueAction(action);
    }
})
