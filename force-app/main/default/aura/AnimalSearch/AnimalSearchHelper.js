({
    fillAnimalDataTable : function(component, event, helper) {
        if (component.get('v.searchResultVisible') == false) {
        	component.set("v.searchResultVisible", "true");    
        }
        component.set('v.animalColumns', [
            	{label: 'Name', fieldName: 'Name', type: 'text'},
            	{label: 'Id', fieldName: 'Id', type: 'text'},
            	{label: 'External Id', fieldName: 'External_Id__c', type: 'text'},
                {label: 'Eats', fieldName: 'Eats__c', type: 'text'},
                {label: 'Says', fieldName: 'Says__c', type: 'text'}
            ]);
        var action = component.get("c.getAnimalsById");
        action.setParams({"externalID" : component.get('v.animalId')});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.animalList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})