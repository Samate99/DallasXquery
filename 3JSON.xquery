(:Kilistázzuk azokat a karaktereket akikhez van kép név és url :)

xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

declare function local:getResultOfDallaCharachters(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?cast?*?character
    return $DallasLink
};

let $Datas :=local:getResultOfDallaCharachters()

return array {
    for $Dallas in $Datas
    where fn:exists($Dallas?image)
    and
    fn:exists($Dallas?name)
        and
    fn:exists($Dallas?url)
    order by $Dallas?id ascending
    return map {
    "image" : $Dallas?image,
    "name" : $Dallas?name,
    "url" : $Dallas?url        
    }
}
