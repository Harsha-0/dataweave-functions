%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date

var SPM = "SPM|:setId:|:specimenId.placerAssignedId.entityIdentifier:&:specimenId.placerAssignedId.name:&:specimenId.placerAssignedId.universalId:&:specimenId.placerAssignedId.uidType:^:specimenId.fillerAssignedId.entityIdentifier:&:specimenId.fillerAssignedId.name:&:specimenId.fillerAssignedId.universalId:&:specimenId.fillerAssignedId.uidType:|:specimenType.identifierCode:^:specimenType.description:^:specimenType.codingSystem:|:specimenCollectionMethod.resultCode:^:specimenCollectionMethod.text:|:specimenSourceSite.resultCode:^:specimenSourceSite.text:|:specimenCollectionDateTime:|:specimenReceivedDateTime:"

var result ={
    (mapping.setId): payload.setId,
    specimenId: {
        placerAssignedId:{
            (mapping.specimenId.placerAssignedId.entityIdentifier): payload.specimenId.placerAssignedId.entityIdentifier,
            (mapping.specimenId.placerAssignedId.name): payload.specimenId.placerAssignedId.name,
            (mapping.specimenId.placerAssignedId.universalId): payload.specimenId.placerAssignedId.universalId,
            (mapping.specimenId.placerAssignedId.uidType): payload.specimenId.placerAssignedId.uidType
        },
        fillerAssignedId :{
            (mapping.specimenId.fillerAssignedId.entityIdentifier): payload.specimenId.fillerAssignedId.entityIdentifier,
            (mapping.specimenId.fillerAssignedId.name): payload.specimenId.fillerAssignedId.name,
            (mapping.specimenId.fillerAssignedId.universalId): payload.specimenId.fillerAssignedId.universalId,
            (mapping.specimenId.fillerAssignedId.uidType): payload.specimenId.fillerAssignedId.uidType
        }
    },
    specimenType :{
        (mapping.specimenType.identifierCode): payload.specimenType.identifierCode,
        (mapping.specimenType.description): payload.specimenType.description,
        (mapping.specimenType.codingSystem): payload.specimenType.codingSystem
    },
    specimenCollectionMethod: {
        (mapping.specimenCollectionMethod.resultCode): payload.specimenCollectionMethod.resultCode,
        (mapping.specimenCollectionMethod.text): payload.specimenCollectionMethod.text

    },
    specimenSourceSite: {
        (mapping.specimenSourceSite.resultCode): payload.specimenSourceSite.resultCode,
        (mapping.specimenSourceSite.text): payload.specimenSourceSite.text
    },
    (mapping.specimenCollectionDateTime): payload.specimenCollectionDateTime,
    (mapping.specimenReceivedDateTime): payload.specimenReceivedDateTime
}

fun spm(data) = SPM
replace  ":setId:" with (data."2"  default "")
replace  ":specimenId.placerAssignedId.entityIdentifier:" with (data.specimenId.placerAssignedId."3.1.1"  default "")
replace  ":specimenId.placerAssignedId.name:" with (data.specimenId.placerAssignedId."3.1.2"  default "")
replace  ":specimenId.placerAssignedId.universalId:" with (data.specimenId.placerAssignedId."3.1.3"  default "")
replace  ":specimenId.placerAssignedId.uidType:" with (data.specimenId.placerAssignedId."3.1.4"  default "")
replace  ":specimenId.fillerAssignedId.entityIdentifier:" with (data.specimenId.fillerAssignedId."3.2.1"  default "")
replace  ":specimenId.fillerAssignedId.name:" with (data.specimenId.fillerAssignedId."3.2.2"  default "")
replace  ":specimenId.fillerAssignedId.universalId:" with (data.specimenId.fillerAssignedId."3.2.3"  default "")
replace  ":specimenId.fillerAssignedId.uidType:" with (data.specimenId.fillerAssignedId."3.2.4"  default "")
replace  ":specimenType.identifierCode:" with (data.specimenType."4.1"  default "")
replace  ":specimenType.description:" with (data.specimenType."4.2"  default "")
replace  ":specimenType.codingSystem:" with (data.specimenType."4.3"  default "")
replace  ":specimenCollectionMethod.resultCode:" with (data.specimenCollectionMethod."5.1"  default "")
replace  ":specimenCollectionMethod.text:" with (data.specimenCollectionMethod."5.2"  default "")
replace  ":specimenSourceSite.resultCode:" with (data.specimenSourceSite."6.1"  default "")
replace  ":specimenSourceSite.text:" with (data.specimenSourceSite."6.2"  default "")
replace  ":specimenCollectionDateTime:" with (parseDate (data."7")  default "")
replace  ":specimenReceivedDateTime:" with (parseDate(data."8")  default "")
---
spm(result)