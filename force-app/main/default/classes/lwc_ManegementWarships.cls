/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 15-07-2022
 * @last modified by  : Fábio Marques
**/
public with sharing class lwc_ManegementWarships {
    @AuraEnabled(cacheable=true)
    public static List<Warship__c> getWarships() {
       return [
            SELECT Id, Name
            FROM Warship__c
            WITH SECURITY_ENFORCED
       ];
       
    }

    @AuraEnabled
    public static List<Warship_Supply__c> getSupllies(String wId) {
        System.debug(wId);
        return [
             SELECT Id, Name, Supply_Name__c, Quantity__c
             FROM Warship_Supply__c
             WHERE Ship_supply__c = :wId
             WITH SECURITY_ENFORCED
        ];
        
     }

}
