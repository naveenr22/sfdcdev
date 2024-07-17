({
    retriveAccounts : function(component) {
        var action = component.get("c.fetchAccounts");
        action.setCallback(this, function(result){
            var state = result.getState();
            if (state == 'SUCCESS') {
                component.set("v.listAcc", result.getReturnValue());
            } else {
                console.error('Failed to fetch accounts with state: ' + state);
            }
        });
        $A.enqueueAction(action);
    }
})
