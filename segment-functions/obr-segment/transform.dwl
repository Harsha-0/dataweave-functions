%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var OBR = "OBR|:orderControl:|:placerOrderNumber.entityIdentifier:^:placerOrderNumber.name:^:placerOrderNumber.universalId:^:placerOrderNumber.uidType:|:fillerOrderNumber.entityIdentifier:^:fillerOrderNumber.name:^:fillerOrderNumber.universalId:^:fillerOrderNumber.uidType:|:testRequested.identifier:^:testRequested.text:^:testRequested.codingSystem:^:testRequested.codingSystemVersion:|:observationBeginDateTime:|:observationEndDateTime:|:dateTimeOfTransaction:|:relevantClinicalInfo:|:specimenReceivedDateTime:|:specimenSource:|:orderingProvider.idNumber:^:orderingProvider.lastName:^:orderingProvider.firstName:^:orderingProvider.MI:^:orderingProvider.suffix:^:orderingProvider.prefix:|:callBackPhoneNumber.value:^:callBackPhoneNumber.'type':|:resultsDateTime:|:resultStatus:|:parentResult.identifier:^:parentResult.text:^:parentResult.codingSystem:^:parentResult.parentObsSubId:^:parentResult.parentObsValueDesc:|:parent.placerAssignedId:^:parent.fillerAssignedId:|:reasonForStudy.identifier:^:reasonForStudy.text:^:reasonForStudy.codingSystem:^:reasonForStudy.date:|:principalResultInterpreter.code:^:principalResultInterpreter.firstName:|"

var result = {
   (mapping.orderControl): payload.orderControl,
   placerOrderNumber: {
       (mapping.placerOrderNumber.entityIdentifier): payload.placerOrderNumber.entityIdentifier,
       (mapping.placerOrderNumber.name): payload.placerOrderNumber.name,
       (mapping.placerOrderNumber.universalId): payload.placerOrderNumber.universalId,
       (mapping.placerOrderNumber.uidType): payload.placerOrderNumber.uidType
   },
   fillerOrderNumber: {
       (mapping.fillerOrderNumber.entityIdentifier): payload.fillerOrderNumber.entityIdentifier,
       (mapping.fillerOrderNumber.name): payload.fillerOrderNumber.name,
       (mapping.fillerOrderNumber.universalId): payload.fillerOrderNumber.universalId,
       (mapping.fillerOrderNumber.uidType): payload.fillerOrderNumber.uidType
   },
   testRequested :{
       (mapping.testRequested.identifier): payload.testRequested.identifier,
       (mapping.testRequested.text): payload.testRequested.text,
       (mapping.testRequested.codingSystem): payload.testRequested.codingSystem,
       (mapping.testRequested.codingSystemVersion): payload.testRequested.codingSystemVersion
   },
   (mapping.observationBeginDateTime): payload.observationBeginDateTime,
   (mapping.observationEndDateTime): payload.observationEndDateTime,
   (mapping.dateTimeOfTransaction): payload.dateTimeOfTransaction,
   (mapping.relevantClinicalInfo): payload.relevantClinicalInfo,
   (mapping.specimenReceivedDateTime): payload.specimenReceivedDateTime,
   (mapping.specimenSource): payload.specimenSource,
   orderingProvider:{
       (mapping.orderingProvider.idNumber): payload.orderingProvider.idNumber,
       (mapping.orderingProvider.lastName): payload.orderingProvider.lastName,
       (mapping.orderingProvider.firstName): payload.orderingProvider.firstName,
       (mapping.orderingProvider.MI): payload.orderingProvider.MI,
       (mapping.orderingProvider.suffix): payload.orderingProvider.suffix,
       (mapping.orderingProvider.prefix): payload.orderingProvider.prefix
   },
   (mapping.resultsDateTime): payload.resultsDateTime,
   (mapping.resultStatus): payload.resultStatus,
   parentResult :{
       (mapping.parentResult.identifier):payload.parentResult.identifier,
       (mapping.parentResult.text):payload.parentResult.text,
       (mapping.parentResult.codingSystem):payload.parentResult.codingSystem,
       (mapping.parentResult.parentObsSubId):payload.parentResult.parentObsSubId,
       (mapping.parentResult.parentObsValueDesc):payload.parentResult.parentObsValueDesc
   },
   parent : {
       (mapping.parent.placerAssignedId): payload.parent.placerAssignedId,
       (mapping.parent.fillerAssignedId): payload.parent.fillerAssignedId
    },
    reasonForStudy :{
        (mapping.reasonForStudy.identifier): payload.reasonForStudy.identifier,
        (mapping.reasonForStudy.text): payload.reasonForStudy.text,
        (mapping.reasonForStudy.codingSystem): payload.reasonForStudy.codingSystem,
        (mapping.reasonForStudy.date): payload.reasonForStudy.date
    },
    principalResultInterpreter:{
        (mapping.principalResultInterpreter.code): payload.principalResultInterpreter.code,
        (mapping.principalResultInterpreter.firstName): payload.principalResultInterpreter.firstName,
        (mapping.principalResultInterpreter.lastName): payload.principalResultInterpreter.lastName
    }
}

fun obr(data) =OBR
replace  ":orderControl:" with (data."2"  default "")
replace  ":placerOrderNumber.entityIdentifier:" with (data.placerOrderNumber."3.1"  default "")
replace  ":placerOrderNumber.name:" with (data.placerOrderNumber."3.2" default "")
replace  ":placerOrderNumber.universalId:" with (data.placerOrderNumber."3.3" default "")
replace  ":placerOrderNumber.uidType:" with (data.placerOrderNumber."3.4" default "")
replace  ":fillerOrderNumber.entityIdentifier:" with (data.fillerOrderNumber."4.1"  default "")
replace  ":fillerOrderNumber.name:" with (data.fillerOrderNumber."4.2"  default "")
replace  ":fillerOrderNumber.universalId:" with (data.fillerOrderNumber."4.3"  default "")
replace  ":fillerOrderNumber.uidType:" with (data.fillerOrderNumber."4.4"  default "")
replace  ":testRequested.identifier:" with (data.testRequested."5.1"  default "")
replace  ":testRequested.text:" with (data.testRequested."5.2"  default "")
replace  ":testRequested.codingSystem:" with (data.testRequested."5.3"  default "")
replace  ":testRequested.codingSystemVersion:" with (data.testRequested."5.4"  default "")
replace  ":observationBeginDateTime:" with (parseDate((data."6"  default "")))
replace  ":observationEndDateTime:" with (parseDate((data."7"  default "")))
replace  ":dateTimeOfTransaction:" with (data."8"  default "")
replace  ":relevantClinicalInfo:" with (data."9"  default "")
replace  ":specimenReceivedDateTime:" with (data."10"  default "")
replace  ":specimenSource:" with (data."11"  default "")
replace  ":orderingProvider.idNumber:" with (data.orderingProvider."12.1"  default "")
replace  ":orderingProvider.lastName:" with (data.orderingProvider."12.2"  default "")
replace  ":orderingProvider.firstName:" with (data.orderingProvider."12.3"  default "")
replace  ":orderingProvider.MI:" with (data.orderingProvider."12.4"  default "")
replace  ":orderingProvider.suffix:" with (data.orderingProvider."12.5"  default "")
replace  ":orderingProvider.prefix:" with (data.orderingProvider."12.6"  default "")
replace  ":callBackPhoneNumber.value:" with (data.callBackPhoneNumber.value  default "")
replace  ":callBackPhoneNumber.'type':" with telephone((payload.callBackPhoneNumber  default []))
replace  ":resultsDateTime:" with (parseDate ((data."14" default "")))
replace  ":resultStatus:" with (data."15" default "")
replace  ":parentResult.identifier:" with (data.parentResult."16.1" default "")
replace  ":parentResult.text:" with (data.parentResult."16.2" default "")
replace  ":parentResult.codingSystem:" with (data.parentResult."16.3" default "")
replace  ":parentResult.parentObsSubId:" with (data.parentResult."16.4" default "")
replace  ":parentResult.parentObsValueDesc:" with (data.parentResult."16.5" default "")
replace  ":parent.placerAssignedId:" with (data.parent."17.1" default "")
replace  ":parent.fillerAssignedId:" with (data.parent."17.2" default "")
replace  ":reasonForStudy.identifier:" with (data.reasonForStudy."18.1" default "")
replace  ":reasonForStudy.text:" with (data.reasonForStudy."18.2" default "")
replace  ":reasonForStudy.codingSystem:" with (data.reasonForStudy."18.3" default "")
replace  ":reasonForStudy.date:" with (parseDate((data.reasonForStudy."18.4" default "")))
replace  ":principalResultInterpreter.code:" with (data.principalResultInterpreter."19.1" default "")
replace  ":principalResultInterpreter.firstName:" with (data.principalResultInterpreter."19.2" default "")
---
obr(result)