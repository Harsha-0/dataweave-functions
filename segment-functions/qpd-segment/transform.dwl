%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date
var QPD = "QPD|:messageQueryNameCode:^:messageQueryNameName:^:messageQueryNameId:|:queryTag:|:idValue:^^^^:identifierCode:|:lastName:^:firstName:^:middleName:^^^^L|:motherMaidenNameLastName:^:motherMaidenNameMiddleName:^:motherMaidenNameFirstName:^^^^^M|:dateOfBirth:|:gender:|:addressArray:|:telephoneArray:|:multipleBirthIndicator:|:birthOrder:|:clientLastUpdatedDate:|:clientLastUpdateFacility:|"

var result = {
  messageQueryName: {
      (mapping.messageQueryName.code): payload.messageQueryName.code,
      (mapping.messageQueryName.name): payload.messageQueryName.name,
      (mapping.messageQueryName.id): payload.messageQueryName.id
  },
  (mapping.queryTag): payload.queryTag,
  id: {
    (mapping.id.value): payload.id.value
  },
  (mapping.identifierCode): payload.identifierCode,
  (mapping.lastName): payload.lastName,
  (mapping.firstName): payload.firstName,
  (mapping.middleName): payload.middleName,
  motherMaidenName:{
      (mapping.motherMaidenName.lastName): payload.motherMaidenName.lastName,
      (mapping.motherMaidenName.firstName): payload.motherMaidenName.firstName,
      (mapping.motherMaidenName.middleName): payload.motherMaidenName.middleName
      },
    (mapping.dateOfBirth): payload.dateOfBirth,
    (mapping.gender): payload.gender,
    (mapping.multipleBirthIndicator): payload.multipleBirthIndicator,
    (mapping.birthOrder): payload.birthOrder,
    (mapping.clientLastUpdatedDate): payload.clientLastUpdatedDate,
    (mapping.clientLastUpdateFacility): payload.clientLastUpdateFacility
}

fun qpd(data)= QPD
replace ":messageQueryNameCode:" with (data.messageQueryName."2.1" default "")
replace ":messageQueryNameName:" with (data.messageQueryName."2.2" default "")
replace ":messageQueryNameId:" with (data.messageQueryName."2.3" default "")
replace ":queryTag:" with (data."3" default "")
replace ":idValue:" with (data.id."4.1" default "")
replace  ":identifierCode:" with (data."4.2" default "")
replace ":lastName:" with (data."5.1" default "")
replace ":firstName:" with (data."5.2" default "")
replace  ":middleName:" with (data."5.3" default "")
replace ":motherMaidenNameLastName:" with (data.motherMaidenName."5.1" default "")
replace  ":motherMaidenNameFirstName:" with (data.motherMaidenName."5.2" default "")
replace ":motherMaidenNameMiddleName:" with (data.motherMaidenName."5.3" default "")
replace ":dateOfBirth:" with (parseDate(data."7")default "")
replace ":gender:" with (data."8" default "")
replace ":addressArray:" with (address(payload.address) default "")
replace  ":multipleBirthIndicator:" with (data."10" default "")
replace ":birthOrder:" with (data."11" default "")
replace ":clientLastUpdatedDate:" with (parseDate(data."12") default "")
replace ":clientLastUpdateFacility:" with (data."13" default "")
replace ":telephoneArray:" with (telephone( payload.telecom) default "")
---
qpd(result)

