%dw 2.0
output application/json
import * from dw::core::Strings
import try from dw::Runtime

// Function to parse date fields 
fun parseDate(date: String): Any = if (try(() -> date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}).success) (date as LocalDateTime {format: "yyyy-MM-dd'T'HH:mm:ss"}) as String {format: "yyyyMMddHHmmss"}else if (try(() -> date as Date {format: "yyyy-MM-dd"}).success)(date as Date {format: "yyyy-MM-dd"}) as String {format: "yyyyMMdd"}else date

// Function to remap object values based on a different mapping object
fun reMap(obj1, obj2) = obj2 match {
    case is Object -> 
      (obj1 mapObject ((value, key, index) -> {((value)substringAfter ".") : obj2[(key)]})) ++ {reMapId: ((obj1[0]) substringBefore ".")}
    case is String -> obj2 
    case is Array -> 
      obj2 map ((item, index) -> (obj1[0] mapObject ((value, key, index) -> {((value)substringAfter ".") : item[(key)]})) ++ {reMapId: ((obj1[0][0]) substringBefore ".")})
    else -> "" 
}

// Function to find the maximum number of fields in the mapping JSON
fun maxFields(mappingJson) = 
  max((flatten((mappingJson mapObject ((value, key, index) -> 
    "values" : value match {
      case is Object -> valuesOf(value)
      case is Array -> value map maxFields($)
      case is String -> value
      else -> 0
    }
  ))..)) map $ as Number)

// Function to process input data
fun inputData(obj) = ((1 to 10) map ((item, index) -> obj mapObject ((value, key, index) -> value match {
        case is Object -> 
          (value.reMapId): value - ("reMapId")
        case is Array -> 
          (value[0].reMapId): value map $ - ("reMapId")
        else -> (mapping[key]): value 
    })))[0] 

// Function to construct a segment for HL7 message format 
fun segmentBuild(data) = 
  data match {
    case is Object -> 
      (1 to max(keysOf(data) map $ as Number)) map ((item) -> data[item as String] default "") joinBy "^"
    case is Array -> 
      (data reduce ((item, acc = "") -> (acc) ++ "~" ++ segmentBuild(item))) substringAfter "~" 
    case is String -> data 
    else -> "" 
  }

// Function to generate an HL7 message 
fun hl7(header, details) = header ++ "|" ++ ((valuesOf(restructure))[2 to -1] map (segmentBuild($)) joinBy "|")


// Determine the maximum number of fields based on the `mapping` input
var maxFieldValue = maxFields(mapping)

// Main result map where the PID object is generated by applying reMap to each element of mapping and payload
var result = {
  PID: keysOf(mapping) 
    map ({($): reMap(mapping[($)], payload[($)]) }) 
    reduce ((item, acc = {}) -> acc ++ item)
}

// Build the restructure map by processing the result.PID and filtering based on maxFieldValue

var restructure = ((0 to maxFieldValue) map (inputData(result.PID) filterObject ((value, key, index) -> key ~= $)))map (($$ + 1): valuesOf($)[0] default "") reduce ((item, acc = {}) -> acc ++ item)

---
hl7("PID", restructure) 
