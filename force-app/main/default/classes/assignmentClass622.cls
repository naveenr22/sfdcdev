public class assignmentClass622 {

    public void multipleDML(){
        Account acc1= new Account();
        acc1.Name='as1';
        acc1.Phone='798208489';
        acc1.Active__c='True';
        acc1.AnnualRevenue=10000;
        insert acc1;

        Account acc2= new Account();
        acc2.Name='as2';
        acc2.Phone='8208489545';
        acc2.Active__c='True';
        acc2.AnnualRevenue=89697;
        insert acc2;
        
        Account acc3= new Account();
        acc3.Name='as3';
        acc3.Phone='452514489';
        acc3.Active__c='True';
        acc3.AnnualRevenue=12341;
        insert acc3;
        Account acc4= new Account();
        acc4.Name='as4';
        acc4.Phone='435747485';
        acc4.Active__c='True';
        acc4.AnnualRevenue=956853235;
        insert acc4;
        Account acc5= new Account();
        acc5.Name='as5';
        acc5.Phone='8963765389';
        acc5.Active__c='False';
        acc5.AnnualRevenue=87963;
        insert acc5;
        //Contact con =new Contact();
        //con.LastName='las1';
        //con.Email='aaa@gmail.com';
        //con.Amount__c=12321;
        //insert con;
        //con.AccountId=acc.Id;
        
    }
    
    public void singleDML(){
        List<Account>acList=new List<Account>();
        Account acc1= new Account();
        acc1.Name='as6';
        acc1.Phone='3464325242';
        acc1.Active__c='True';
        acc1.AnnualRevenue=7457;
        acList.add(acc1);
        
        Account acc2= new Account();
        acc2.Name='as7';
        acc2.Phone='45634232';
        acc2.Active__c='True';
        acc2.AnnualRevenue=8659;
        acList.add(acc2);
        
        Account acc3= new Account();
        acc3.Name='as8';
        acc3.Phone='8964467';
        acc3.Active__c='True';
        acc3.AnnualRevenue=7684;
        acList.add(acc3);
        Account acc4= new Account();
        acc4.Name='as9';
        acc4.Phone='4574245563';
        acc4.Active__c='True';
        acc4.AnnualRevenue=76867;
        acList.add(acc4);
        Account acc5= new Account();
        acc5.Name='as10';
        acc5.Phone='563224566';
        acc5.Active__c='False';
        acc5.AnnualRevenue=86784;
        acList.add(acc5);
        insert acList;
        System.debug('size%%%%%'+acList.size());
        
    }
    public void StudentMultipledml(){
        /*student__c st= new student__c();
        st.Name__c='studentas1';
        st.Gender__c='Male';
        st.Application_Status__c='Submitted';
        st.Phone__c='54625625';
        insert st;
        */
        student__c st2= new student__c();
        st2.Name__c='studentas2';
        st2.Gender__c='Male';
        st2.Application_Status__c='Submitted';
        st2.Phone__c='5462752';
        insert st2;
        
        student__c st3= new student__c();
        st3.Name__c='studentas3';
        st3.Gender__c='Female';
        st3.Application_Status__c='Recieved';
        st3.Phone__c='78483355';
        insert st3;
        
        student__c st4= new student__c();
        st4.Name__c='studentas4';
        st4.Gender__c='Male';
        st4.Application_Status__c='Submitted';
        st4.Phone__c='6727373';
        insert st4;
        
        student__c st5= new student__c();
        st5.Name__c='studentas5';
        st5.Gender__c='Female';
        st5.Application_Status__c='Submitted';
        st5.Phone__c='54625625';
        insert st5;
        
            
    }
    public void singlestudentDml(){
        List<student__c> stList=new List<student__c>();
        student__c st= new student__c();
        st.Name__c='studentas6';
        st.Gender__c='Male';
        st.Application_Status__c='Submitted';
        st.Phone__c='54625625';
        stList.add(st);
        
        student__c st2= new student__c();
        st2.Name__c='studentas7';
        st2.Gender__c='Male';
        st2.Application_Status__c='Submitted';
        st2.Phone__c='5462752';
        stList.add(st2);
        
        student__c st3= new student__c();
        st3.Name__c='studentas8';
        st3.Gender__c='Female';
        st3.Application_Status__c='Recieved';
        st3.Phone__c='78483355';
        stList.add(st3);
        
        student__c st4= new student__c();
        st4.Name__c='studentas9';
        st4.Gender__c='Male';
        st4.Application_Status__c='Submitted';
        st4.Phone__c='6727373';
        stList.add(st4);
        
        student__c st5= new student__c();
        st5.Name__c='studentas10';
        st5.Gender__c='Female';
        st5.Application_Status__c='Submitted';
        st5.Phone__c='54625625';
        stList.add(st5);
        
            
    }
    public void inscontact3(){
        Contact c1=new Contact();
         c1.LastName='conas1';
        Contact c2=new Contact();
         c2.LastName='conas2';
        Contact c3=new Contact();
         c3.LastName='conas3';
         Contact c4=new Contact();
         c4.LastName='conas4';
          Contact c5=new Contact();
         c5.LastName='conas5';

        Map<Id,Contact> conin=new Map<Id,Contact>();
        conin.put(c1.Id,c1);
        conin.put(c2.Id,c2);
        conin.put(c3.Id,c3);
        conin.put(c4.Id,c4);
        conin.put(c5.Id,c5); 
        
    }
    ///from here qt4
    public void createAccount(){
        Account a=new Account();
        a.Name='as11';
        a.Phone='543252521';
        a.Active__c='True';
        a.AnnualRevenue=62634;
        insert a;
    }
    public void createContact(String ln,String em, Integer am){
        Contact cont =new Contact();
        cont.LastName=ln;
        cont.Email=em;
        cont.Amount__c=am;
        insert cont;
    }
    public static void createOpportunity(){
        Opportunity op=new Opportunity();
        op.StageName='Closed Won';
        op.Amount=5145145;
        op.Name='bmw';
        insert op;
    }
    public static void createCase(String ori,String sta){
        Case c = new Case();
        c.Origin=ori;
        c.Status=sta;
    }
    public static String studid(){
        //select Id from student__c;
        student__c s=new student__c();
        s.Name__c='testingstid';
        return s.Id;
    }
    
    public static void CreateAccConOpp(String accountName, String contactName, String opportunityName) {
        // Create the Account
        Account acc = new Account();
        acc.Name = accountName;
        insert acc;
        
        // Create the Contact
        Contact con = new Contact();
        con.FirstName = contactName;
        con.AccountId = acc.Id;
        insert con;
        
        // Create the Opportunity
        Opportunity opp = new Opportunity();
        opp.Name = opportunityName;
        opp.AccountId = acc.Id;
        opp.CloseDate = Date.today().addDays(30);
        insert opp;
    
}

    
}