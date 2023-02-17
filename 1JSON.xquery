(:Itt kilistázzuk az első évad azon epizódjait amelyek 1979 előtt játszódtak és rendezzük őket csökkenő sorrendbe a dátum alapján :)


declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

declare function local:getResultOftheEpisodesIn(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?episodes?*
    return $DallasLink
};

let $datas :=local:getResultOftheEpisodesIn()

return array {    

    for $Dallas in $datas
    where $Dallas?season = 1
    and
    xs:date("1979-01-01")>  xs:date($Dallas?airdate)
    order by $Dallas?airdate descending
    return map {
        "id" : $Dallas?id,
        "url" : $Dallas?url,
        "name": $Dallas?name,
        "airdate" : $Dallas?airdate,
        "runtime" : $Dallas?runtime

    }

}

