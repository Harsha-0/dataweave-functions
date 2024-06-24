%dw 2.0
import * from dw::core::Strings
import * from dw::core::Arrays
import try from dw::Runtime

fun address(add:Array):Any = (add reduce ((item, acc = "") -> (acc) ++ "~" ++ ((item.line1 default "") ++ "^" ++ (item.line2 default "") ++ "^" ++ (item.city default "")++ "^" ++ (item.state default "") ++ "^" ++ (item.postalCode default "")++ "^" ++ (item.append default "BDL")) ))substringAfter "~"

fun telephone(contact:Array):Any =  (contact reduce ((item, acc = "") -> acc ++"~"++(item.anyText  default "") ++ "^"++(item.code  default "") ++ "^" ++ (item."type"  default "") ++ "^" ++(item.emailAddress default "") ++"^"++ (item.text  default "") ++"^"++ (item.number[0 to 2]  default "")++ "^" ++ (item.number[3 to -1]  default "") )) substringAfter "~"

fun parseDate(date: String):Any = if(try(()-> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"} as String {format: "yyyyMMddHHmmss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"} else if(try(()-> date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}).success) (date as Date {format: "yyyy-MM-dd"} as String {format: "yyyyMMdd"}) else date
var QPD = "QPD|:messageQueryNameCode:^:messageQueryNameName:^:messageQueryNameId:|:queryTag:|:idValue:^^^^:identifierCode:|:lastName:^:firstName:^:middleName:^^^^L|:motherMaidenNameLastName:^:motherMaidenNameMiddleName:^:motherMaidenNameFirstName:^^^^^M|:dateOfBirth:|:gender:|:addressArray:|:telephoneArray:|:multipleBirthIndicator:|:birthOrder:|:clientLastUpdatedDate:|:clientLastUpdateFacility:|"

fun qpd(data)= QPD
replace ":messageQueryNameCode:" with (data.messageQueryName.code default "")
replace ":messageQueryNameName:" with (data.messageQueryName.name default "")
replace ":messageQueryNameId:" with (data.messageQueryName.id default "")
replace ":queryTag:" with (data.queryTag default "")
replace ":idValue:" with (data.id.value default "")
replace  ":identifierCode:" with (data.identifierCode default "")
replace ":lastName:" with (data.lastName default "")
replace ":firstName:" with (data.firstName default "")
replace  ":middleName:" with (data.middleName default "")
replace ":motherMaidenNameLastName:" with (data.motherMaidenName.lastName default "")
replace  ":motherMaidenNameFirstName:" with (data.motherMaidenName.firstName default "")
replace ":motherMaidenNameMiddleName:" with (data.motherMaidenName.middleName default "")
replace ":dateOfBirth:" with (parseDate(data.dateOfBirth)default "")
replace ":gender:" with (data.gender default "")
replace ":addressArray:" with (address(data.address) default "")
replace  ":multipleBirthIndicator:" with (data.multipleBirthIndicator default "")
replace ":birthOrder:" with (data.birthOrder default "")
replace ":clientLastUpdatedDate:" with (parseDate(data.clientLastUpdatedDate) default "")
replace ":clientLastUpdateFacility:" with (data.clientLastUpdateFacility default "")
replace ":telephoneArray:" with (telephone( data.telecom) default "")
---
qpd(payload)

