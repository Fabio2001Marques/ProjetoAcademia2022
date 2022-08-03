/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 12-07-2022
 * @last modified by  : Fábio Marques
**/
trigger WarSupTrigger on  Warship_Supply__c (before insert, before update, before delete ) {
    
    new WarSupTriggerHandler().run();
    
}