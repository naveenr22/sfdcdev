({
    searchAccounts: function (component, event, helper) {
        var searchString = component.get("v.searchKeyword");
        console.log(searchString);
        var action = component.get("c.getAccounts");
        console.log(action);
        action.setParams({
            "enteredkeyword": searchString
        });
        action.setCallback(this, function (response) {
            var state = response.getState();
            console.log('state :::::: '+state);
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.resultAccList", response.getReturnValue());
                if(response.getReturnValue().length == 0) {
                    component.set("v.errorMessage", true);
                } else {
                    component.set("v.errorMessage", false);
                }
            } else {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },

    createNewAccount: function (component, event, helper){
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Account"
        });
        createRecordEvent.fire();
    }
})
