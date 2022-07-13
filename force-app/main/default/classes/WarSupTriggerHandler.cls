/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 12-07-2022
 * @last modified by  : Fábio Marques
**/
public with sharing class WarSupTriggerHandler extends TriggerHandler{
    
    public override void beforeInsert(){
        WarSupUtility.insertSupplies(Trigger.new);
    }
    public override void beforeUpdate(){
        WarSupUtility.updateSupplies(Trigger.old, Trigger.new);
    }
    public override void beforeDelete(){
        WarSupUtility.deleteSupplies(Trigger.old);
    }
}