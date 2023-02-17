(: Itt megtekinthetjük azokat a Női szereplőket akik 1946 előtt születtek, illetve rendezzük őket a nevük és születésük szerint.:)
(: XML SCHEMA :)

xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace validate = "http://basex.org/modules/validate";

import schema default element namespace "" at "1XSD.xsd";

declare option output:indent "yes";
declare function local:getResultOfCast(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?cast?*?person
    return $DallasLink
};


let $Female :=local:getResultOfCast()

    
return validate {document {
    <Female>
        {
          for $Data in $Female
          let $name := $Data?name
          let $birthday := $Data?birthday
          let $url := $Data?url           
          where $Data?gender = "Female"
          and
          xs:date("1946-01-01") >  xs:date($Data?birthday)         
          order by $name ascending, $birthday ascending
          return 
          <OldFemaleActors>
            <name>{$Data?name}</name>
            <birthday>{$Data?birthday}</birthday>
            <url>{$Data?url}</url>
          </OldFemaleActors>
        }
    </Female>}
    }