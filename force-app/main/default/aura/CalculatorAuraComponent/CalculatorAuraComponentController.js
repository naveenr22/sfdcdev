({
    
        Total:function (component, event, helper) {
        var mathMarks = component.get ( "v.mathsMarks"); //12
        var PhyMarks = component.get ( "v.phyMarks"); //24
        var ChemMarks = component.get ( "v.chemMarks"); //23
        console.log (mathMarks) ;
        var result=parseInt (mathMarks)+parseInt (PhyMarks)+parseInt (ChemMarks) ;
        console.log(result);
        component.set("v.result",result);
        }
        
        
})
