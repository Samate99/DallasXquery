(:Kilistázzuk a 1981ben kiadott epizódokat amelyeknek az értéke "null":)


xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace validate = "http://basex.org/modules/validate";
import schema default element namespace "" at "4XSD.xsd";
declare option output:indent "yes";

declare function local:getResultOfDallasEpisodes(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?episodes?*
    return $DallasLink
};

declare function local:getResultOfEpisodesBeetween($season){
    for $Dallas in $season
    where xs:date("1981-01-01") < xs:date($Dallas?airdate)
    and
    xs:date("1981-12-31") > xs:date($Dallas?airdate)
    and
    fn:not(fn:exists($Dallas?rating?average))
    order by $Dallas?type
    
    return map {
        "name" : $Dallas?name,
        "season": $Dallas?season,
        "number": $Dallas?number,
        "airdate": $Dallas?airdate,
        "type" : $Dallas?type,
        "airtime" : $Dallas?airtime
        
        }
};


let $Episodes :=local:getResultOfDallasEpisodes()
let $Data :=local:getResultOfEpisodesBeetween($Episodes)


return validate {document {
                    <data>{
                    for $Data in $Data
                    return
                    <oldepisodes>
                        <name>{$Data?name}</name>  
                        <season>{$Data?season}</season>   
                        <number>{$Data?number}</number>
                        <airdate>{$Data?airdate}</airdate>  
                        <Types>{$Data?type}</Types>
                        <airtime>{$Data?airtime}</airtime>                          
                    </oldepisodes>
                                       } </data>
                   }
}

