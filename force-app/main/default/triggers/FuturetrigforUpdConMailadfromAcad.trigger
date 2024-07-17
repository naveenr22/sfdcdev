
    trigger FuturetrigforUpdConMailadfromAcad on Account (after update) {
        for(Account a : Trigger.new) {
            Account oldAccount = Trigger.oldMap.get(a.Id);
            if(oldAccount.ShippingStreet != a.ShippingStreet || oldAccount.ShippingCity != a.ShippingCity || oldAccount.ShippingState != a.ShippingState || oldAccount.ShippingPostalCode != a.ShippingPostalCode || oldAccount.ShippingCountry != a.ShippingCountry) {
                FutureUpdConMailAdrsfromBilAcAd.updateContactAddresses(a.Id, a.ShippingStreet, a.ShippingCity, a.ShippingState, a.ShippingPostalCode, a.ShippingCountry);
            }
        }
    }
    
