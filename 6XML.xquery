(: kilistázni az első 5 epizódját azoknak az évadoknak amelyek 1985 és 1991 között keszültek :)

xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace validate = "http://basex.org/modules/validate";

import schema default element namespace "" at "6XSD.xsd";

declare option output:indent "yes";
declare function local:getResultOfFirstSeasonEpisodes(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?episodes?*
    return $DallasLink
};

let $EpisodeOne :=local:getResultOfFirstSeasonEpisodes()


return validate {document { 
    <Six>
        {
          for $Dallas in $EpisodeOne
          let $name := $Dallas?name
          let $birthday := $Dallas?birthday
          let $url := $Dallas?url
          let $season :=  $Dallas?season
          let $number:=  $Dallas?number
          let $airdate :=  $Dallas?airdate
          let $runtime :=  $Dallas?runtime
                where $Dallas?number <= 5 
                 and
                 xs:date("1991-01-31")>  xs:date($Dallas?airdate)
                 and
                xs:date("1985-01-01")<  xs:date($Dallas?airdate)
            
          order by $birthday ascending
          return 
          <FirstFive>
            <name>{$Dallas?name}</name>
            <birthday>{$Dallas?birthday}</birthday>
            <url>{$Dallas?url}</url>
             <season>{$Dallas?season}</season>
             <number>{$Dallas?number}</number>
            <airdate>{$Dallas?airdate}</airdate>
            <runtime>{$Dallas?runtime}</runtime>
          </FirstFive>
        }
    </Six>}}