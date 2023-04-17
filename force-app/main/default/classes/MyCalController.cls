public with sharing class MyCalController {
    @AuraEnabled(cacheable=true)
    public Static List<Event> MyEvents() {
        List<Event> eventList = new List<Event>();
        eventList = [Select Id, Subject, WhatId, WhoId, 
                    Description, EndDate, EndDateTime, OwnerId,
                    ActivityDate, ActivityDateTime From Event ];
        return eventList;
    }
}