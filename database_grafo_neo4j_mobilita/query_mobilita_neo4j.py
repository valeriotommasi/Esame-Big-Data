from neo4j import GraphDatabase


URI = "bolt://127.0.0.1:7687"
USERNAME = "neo4j"
PASSWORD = "password"


driver = GraphDatabase.driver(URI, auth=(USERNAME, PASSWORD))

query_1 = """
MATCH percorso = shortestPath(
    (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*]-(arrivo:Fermata {nome: "Ospedale Centrale"})
)
RETURN percorso;
"""

query_2 = """
MATCH percorso = (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*1..6]-(fermata:Fermata)
MATCH (poi:PuntoInteresse)-[v:VICINO_A]->(fermata)
RETURN DISTINCT 
    poi.nome AS punto_interesse,
    poi.categoria AS categoria,
    fermata.nome AS fermata_vicina,
    length(percorso) AS numero_tratte,
    v.distanza_metri AS distanza_dalla_fermata
ORDER BY numero_tratte;
"""


with driver.session() as session:
    print("\nQUERY 1 - Percorso più breve tra due fermate")
    risultati_1 = session.run(query_1)

    for record in risultati_1:
        print(record.data())

    print("\nQUERY 2 - Punti di interesse raggiungibili dalla Stazione Centrale")
    risultati_2 = session.run(query_2)

    for record in risultati_2:
        print(record.data())


driver.close()