// QUERY 1 (trovare il percorso più bre tra due fermate)

MATCH percorso = shortestPath(
    (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*]-(arrivo:Fermata {nome: "Ospedale Centrale"})
)
RETURN percorso;


// QUERY 2 (Individuare quali punti di interesse sono raggiungibili con al massimo due cambi da una certa stazione.)

MATCH percorso = (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*1..6]-(fermata:Fermata)
MATCH (poi:PuntoInteresse)-[v:VICINO_A]->(fermata)
RETURN DISTINCT 
    poi.nome AS punto_interesse,
    poi.categoria AS categoria,
    fermata.nome AS fermata_vicina,
    length(percorso) AS numero_tratte,
    v.distanza_metri AS distanza_dalla_fermata
ORDER BY numero_tratte;