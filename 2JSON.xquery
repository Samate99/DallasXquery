(:Kiszámolja a színészek jelenegi életkorát illetve ha elhunytak az eletkorukat az eltávozásukkor:)

xquery version "3.1";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "json";
declare option output:media-type "application/json";
declare option output:indent "yes";

declare function local:getResultOfTheDefaultDallas(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?cast?*?person
    return $DallasLink
};




let $Datas :=local:getResultOfTheDefaultDallas()
let $date := current-date()


return array {
    for $Dallas in $Datas
    order by $Dallas?birthday
    return map {
    "name" : $Dallas?name,
    "gender" : $Dallas?gender,
    "birthday": $Dallas?birthday,
    "Deathday":  if(fn:exists($Dallas?deathday))  then (xs:date($Dallas?deathday)) else  ("he/she is still alive") ,
    "Age" : if(fn:not(fn:exists($Dallas?deathday)))  then (fn:year-from-date($date) -  fn:year-from-date(xs:date($Dallas?birthday))) else  (fn:year-from-date(xs:date($Dallas?deathday)) -  fn:year-from-date(xs:date($Dallas?birthday))) 
    
    }
}

