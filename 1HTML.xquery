(: Listázzuk a 85 es 89 közötti évadok amelyeket az USABAN forgattak es 27nél több epizóddal rendelkeznek :)
(: XML SCHEMA :)

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";
declare namespace op = "http://www.w3.org/2002/08/xquery-operators";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

declare function local:getResultOfSeasons(){
    let $Dallas := json-doc("Dallas.json")?("_embedded")?seasons?*
    return $Dallas
};



let $datas :=local:getResultOfSeasons()

let $document := 

<html>
    <head>
        <title>Seasons between with 26 more episodes 85'-89'</title>
    </head>
    <body>
            <section>
            <h1>Dallas</h1>
                <div>
                    <div>
                    <div>
                        <table>
                            <thead>
                                    <tr>
                                        <th>Évad</th>
                                        <th>Premier</th>
                                        <th>készítő ország</th>
                                        <th>Epizódok száma</th>
                                        <th>TVmaze link</th>
                                    </tr>
                                </thead>
                                <tbody>  { for $Data in $datas
                                        let $season := $Data?title
                                        let $premiereDate := $Data?season?title
                                        let $code := $Data?seasonNumber
                                        let $episodeOrder := $Data?episodeNumber
                                        where xs:date("1985-09-27")< xs:date($Data?premiereDate)
                                         and
                                         xs:date("1989-09-22")> xs:date($Data?premiereDate)
                                        and
                                        $Data?network?country?code = "US"
                                         and
                                        $Data?episodeOrder > 27
                                        order by $season ascending
                                        return                                  
                                            <tr>
                                                <td>{$Data?number}</td>
                                                <td>{$Data?premiereDate}</td>
                                                <td>{$Data?network?country?code}</td>
                                                <td>{$Data?episodeOrder}</td>
                                            </tr>
                                }
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </section>
    </body>
</html>

return $document



