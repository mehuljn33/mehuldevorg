@isTest
public class TestVerifyDate {
@isTest static void test1()
{
Date ds=VerifyDate.CheckDates(System.today(),System.today());
System.assertEquals(System.today(),ds); 
Date ds1=VerifyDate.CheckDates(System.today(),System.today().addDays(32));
Integer totalDays = Date.daysInMonth(System.today().year(), System.today().month());
Date ds2 = Date.newInstance(System.today().year(), System.today().month(), totalDays);  
System.assertEquals(ds2,ds1);   
}    
}