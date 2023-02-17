(: Itt megtekinthetjuk azokat a férfi szereplőket akik Amerikaiak illetve elhunytak 2000 után :)

xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";



import schema default element namespace "" at "2XSD.xsd";

declare option output:indent "yes";

declare function local:getResultOfCastMembers(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?cast?*?person
    return $DallasLink
};

declare function local:getResultOfMaleUSActorsDieadAfter($DeadMales){

    for $Dallas in $DeadMales
    where fn:exists($Dallas?deathday)
    and 
    $Dallas?gender = "Male"
    and
    $Dallas?country?name = "United States"
    and
    xs:date("2000-01-01")<  xs:date($Dallas?deathday)
    order by $Dallas?birthday
    return map {
        "name": $Dallas?name,
        "gender": $Dallas?gender,
        "birthday": $Dallas?birthday,
        "deathday": $Dallas?deathday,
        "url": $Dallas?url
        
    }
};

let $Males :=local:getResultOfCastMembers()
let $data := local:getResultOfMaleUSActorsDieadAfter($Males)


return validate {document {
                    <Data>{
                    for $Data in $data
                    return
                    <DeadMales>
                        <name>{$Data?name}</name>
                        <gender>{$Data?name}</gender>
                        <birthday>{$Data?birthday}</birthday>
                        <deathday>{$Data?deathday}</deathday>
                        <url>{$Data?url}</url>
                    </DeadMales>
                  }  </Data>
                   }
                   }

