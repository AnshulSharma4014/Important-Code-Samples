HttpRequest req = new HttpRequest();
req.setMethod('GET');
req.setEndpoint('https://images.unsplash.com/photo-1608231975456-2f2d9fb1b49b?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=800&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY3NzEyNDUwMw&ixlib=rb-4.0.3&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=1900');
req.setHeader('Content-Type', 'application/json');
req.setTimeout(60000);
HttpResponse res = new Http().send(req);

if(res.getStatusCode() == 200) {
    
    ContentVersion contentVersionRec = new ContentVersion();
    contentVersionRec.Title = 'Test File';
    contentVersionRec.PathOnClient = 'Test file.png';
    contentVersionRec.VersionData = res.getBodyAsBlob();
    contentVersionRec.IsMajorVersion = true;
    insert contentVersionRec;
    
    contentVersionRec = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id =: contentVersionRec.Id];
    ContentDocumentLink cdl = new ContentDocumentLink();
    cdl.LinkedEntityId = '0013R000006TTJfQAO';
    cdl.ContentDocumentId = contentVersionRec.ContentDocumentId;
    cdl.ShareType = 'V';
    cdl.Visibility = 'AllUsers';
    insert cdl;
    
    System.debug('Success, cdl Id = '+cdl.Id);
} else {
    System.debug('Error: '+res.getStatusCode()+', '+res.getBody());
}
