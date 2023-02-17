(: Kiiratjuk azokat a férfi stábtagokat akiknek az adathalmazban nincs megjelölve se születési se halálozási dátum. Rendezzük őket az ID alapjan illetve megtekinthető a foglalkozásuk/szerepkörük is :)

xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace validate = "http://basex.org/modules/validate";
import schema default element namespace "" at "3XSD.xsd";

declare option output:indent "yes";


declare function local:getResultOfCrewMales(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?crew?*
    return $DallasLink
};


declare function local:getResultOfCrewMembersWithoutDatas($crew){
    for $Dallas in $crew
    where fn:not(fn:exists($Dallas?person?birthday))
    and
     fn:not(fn:exists($Dallas?person?deathday))
    and
    $Dallas?person?gender = "Male"
    order by $Dallas?person?id
    
    return map {
        "Types": $Dallas?type,
        "Names": $Dallas?person?name,
        "Gender": $Dallas?person?gender
    }
};

let $result :=local:getResultOfCrewMales()
let $Data :=local:getResultOfCrewMembersWithoutDatas($result)

return validate {document {
                    <data>{
                    for $Data in $result
                    return
                    <CrewMales>
                        <Types>{$Data?type}</Types>
                        <Names>{$Data?person?name}</Names>                          
                        <gender>{$Data?person?gender}</gender>
                    </CrewMales>
                     }</data>
                   }
                   }