/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 14-07-2022
 * @last modified by  : Fábio Marques
**/
trigger SupplyTrigger on Supply__c (before insert, before update) {
    List<Supply__c> newSupplies = Trigger.new;
    List<Supply__c> oldSupplies = Trigger.old;
    Boolean x = true;
   
    List<Supply__c> supply = [SELECT Id, Name  FROM Supply__c];

    List<AggregateResult> ws = [Select Supply__c, sum(Quantity__c) From Warship_Supply__c Group by Supply__c];

    if(Trigger.isInsert){
        for(Supply__c s : supply){
            for(Supply__c newS : newSupplies){           
                if(s.Name == newS.Name){
                    newS.addError('A supply with this name already exists');
                }else {
                    newS.Total_Quantity__c = newS.Quantity__c;
                }  
            }
        }
    }else {
        for(Supply__c s : supply){
            for(Supply__c newS : newSupplies){
                for(Supply__c oldS : oldSupplies){
                    if(newS.Id == oldS.id){
                        if(oldS.Name != newS.Name){ 
                            if(s.Name == newS.Name){
                                newS.addError('A supply with this name already exists');
                                x = false;
                            }
                        }                                              
                    } 
                }
            }
        }
        if (x) {
            for(Supply__c newS : newSupplies){
                for (AggregateResult ws : ws) {
                    if (newS.Id == ws.get('Supply__c')) {
                        newS.Total_Quantity__c = newS.Quantity__c + Integer.valueOf(ws.get('expr0'));
                    }
                }
            }
        }     
    }

}