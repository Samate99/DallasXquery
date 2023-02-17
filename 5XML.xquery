(: Kilistázza a nem Amerikai női színészeket akik 1950 után születtek és még napjainkban is élnek :)


xquery version "3.1";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace validate = "http://basex.org/modules/validate";

import schema default element namespace "" at "5XSD.xsd";
declare option output:indent "yes";

declare function local:getResultOfCastNotFromUS(){
    let $DallasLink := json-doc("Dallas.json")?("_embedded")?cast?*?person
    return $DallasLink
};

let $Country :=local:getResultOfCastNotFromUS()

    
return validate {document {
    <FemaleForeign>
        {
          for $Data in $Country
          let $name := $Data?name
          let $birthday := $Data?birthday
          let $deathday := $Data?deathday
          let $Fname := $Data?country?name
          let $Fcode:= $Data?country?code
          where $Data?country?name != "United States"
          and
          xs:date("1950-01-01")<  xs:date($Data?birthday)
          and
          fn:not(fn:exists($Data?deathday))
          order by $name ascending, $birthday ascending
          return 
          <ForeignLiveFemaleActors>
            <name>{$Data?name}</name>
            <birthday>{$Data?birthday}</birthday>
            <deathday>{$Data?deathday}</deathday>
            <Fname>{$Data?country?name}</Fname>
            <Fcode>{$Data?country?code}</Fcode>
          </ForeignLiveFemaleActors>
        }
    </FemaleForeign>}
 }