/**
 * @description       : 
 * @author            : Fábio Marques
 * @group             : 
 * @last modified on  : 05-08-2022
 * @last modified by  : Fábio Marques
**/
public with sharing class popUpClass {

    public Boolean displayPopup {get;set;}

    public popUpClass(ApexPages.StandardController controller) {

    }
    
    public void showPopup()
    {
        
    displayPopup = true;

    
    }
    
    public void closePopup() {
        displayPopup = false;
        
    }
    
    public PageReference redirectPopup()
    {
    displayPopup = false;
        //Please uncomment below 3 statements and replace YourObjectId
        PageReference p=new Pagereference('/a007Q000008DB4OQAW');
         p.setRedirect(true);
         return p;
        
    }
    


}