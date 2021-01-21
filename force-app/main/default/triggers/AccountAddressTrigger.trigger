trigger AccountAddressTrigger on Account (before insert, before update) {

  for(Account a : trigger.new)
  {
    if(a.BillingPostalCode != null && a.Match_Billing_Address__c == true)
    {
      a.ShippingPostalCode = a.BillingPostalCode;
    }
  }
}