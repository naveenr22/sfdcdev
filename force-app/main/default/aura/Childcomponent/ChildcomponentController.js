({
	handleClick : function(component, event, helper) {
        console.log('Entering into HandleClick :::: ');
        var compEvent = component.getEvent("sampleComponent");
        console.log('compEvent :::::: '+compEvent);
        console.log('Test ::::::: '+component.get("v.enteredText"));
        compEvent.setParams({
            "message" : component.get("v.enteredText")
        });
        compEvent.fire();
	}
})
