/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 13-07-2022
 * @last modified by  : Fábio Marques
**/
public class TestDataFactory {

    public static Account createAccount(){
        Account account = new Account();

        account.Name = 'Loba';
        account.BillingCity = 'city';
        account.BillingStreet = 'city';
        account.BillingPostalCode = '9871';
        account.BillingCountry = 'Portugal';
        account.SLA__c = 'Gold';
        account.SLAExpirationDate__c = System.today().addDays(30);
        account.SLASerialNumber__c = '12345aa';

        insert account;

        return account;
    }

    public static List<Supply__c> createSupplies(Integer nSupplies){
        List<Supply__c> supplies = new List<Supply__c>();

        for (Integer i = 0; i < nSupplies; i++) {
            Supply__c s = new Supply__c();
            s.Name = 'Teste DataFactory'+i;
            s.Quantity__c = i+10;
            s.Unit_Cost__c = i+1;
            supplies.add(s);
        }
        return supplies; 
    }

    public static List<Warship__c> createWarship(Integer nWarships){
        List<Warship__c> warships = new List<Warship__c>();
        Account acc = createAccount();
        for (Integer i = 0; i < nWarships; i++) {
            Warship__c w = new Warship__c();
            w.Name = 'Teste DataFactory'+i;
            w.Weapons_Status__c = 'Not Yet Operational';
            w.Account__c = acc.Id;
            warships.add(w);
        }
        return warships;
    }



    public static void createWarSup (Integer newWarSup){
        List<Warship_Supply__c> warshipSuplly = new List<Warship_Supply__c>();
        List<Supply__c> supplies = createSupplies(newWarSup);
        List<Warship__c> warships = createWarship(1);
        insert supplies;
        insert warships;
        for (Warship__c w : warships) {
            for (Integer i = 0; i < newWarSup; i++) {
                Warship_Supply__c warSup = new Warship_Supply__c();
                warSup.Ship_supply__c = w.Id;
                warSup.Supply__c = supplies[i].Id;
                warSup.Quantity__c = i+1;
                warshipSuplly.add(warSup);
            }
        }      
        insert warshipSuplly; 
    }

    public static void createWarshipsWithMilestones(){
        List<Warship__c> warships = createWarship(3);
        insert warships;
        
        List<Milestone__c> milestones = new List<Milestone__c>();
 
        for (Integer i = 0; i < 5; i++) {
            Milestone__c ms = new Milestone__c();
            ms.Name = 'Teste 1'+i;
            ms.Warship__c = warships[0].Id;
            ms.Status__c = 'On Track';
            ms.Due_Date__c = System.today().addDays(i+1);
            milestones.add(ms);
        }
        for (Integer i = 0; i < 5; i++) {
            Milestone__c ms = new Milestone__c();
            ms.Name = 'Teste 2'+i;
            ms.Warship__c = warships[1].Id;
            if(i == 0){
                ms.Status__c = 'Behind Schedule';
            }else{
                ms.Status__c = 'On Track';
            }
            ms.Due_Date__c = System.today().addDays(i+1);
            milestones.add(ms);
        }
        for (Integer i = 0; i < 5; i++) {
            Milestone__c ms = new Milestone__c();
            ms.Name = 'Teste 2'+i;
            ms.Warship__c = warships[2].Id;
            ms.Status__c = 'Behind Schedule';
            ms.Due_Date__c = System.today().addDays(i+1);
            milestones.add(ms);
        }
        insert milestones;

    }

    public static void createMilestones(Integer nMilestones){
        List<Warship__c> warships = createWarship(1);
        insert warships;  

        List<Milestone__c> milestones = new List<Milestone__c>();

        for (Integer i = 0; i < nMilestones; i++) {
            Milestone__c ms = new Milestone__c();
            ms.Name = 'Teste 1'+i;
            ms.Warship__c = warships[0].Id;
            ms.Status__c = 'On Track';
            ms.Due_Date__c = System.today().addDays(i);
            milestones.add(ms);
        }

        insert milestones;
    }
}