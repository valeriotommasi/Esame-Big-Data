from neo4j import GraphDatabase


# Dati di connessione a Neo4j
URI = "bolt://127.0.0.1:7687"
USERNAME = "neo4j"
PASSWORD = "Solotop97"  # sostituisci con la tua password


def esegui_query(driver, query):
    """
    Esegue una query Cypher e restituisce i risultati.
    """
    with driver.session() as session:
        risultato = session.run(query)
        return [record.data() for record in risultato]


def stampa_risultati(titolo, risultati):
    """
    Stampa i risultati in modo semplice e leggibile.
    """
    print("\n" + "=" * 80)
    print(titolo)
    print("=" * 80)

    if not risultati:
        print("Nessun risultato trovato.")
        return

    for i, riga in enumerate(risultati, start=1):
        print(f"\nRisultato {i}:")
        for chiave, valore in riga.items():
            print(f"{chiave}: {valore}")


def main():
    # Connessione al database Neo4j
    driver = GraphDatabase.driver(URI, auth=(USERNAME, PASSWORD))

    # QUERY 1: trovare il percorso più breve tra due fermate
    query_1 = """
    MATCH percorso = shortestPath(
        (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*]-(arrivo:Fermata {nome: "Ospedale Centrale"})
    )
    RETURN percorso;
    """

    # QUERY 2: punti di interesse raggiungibili da una certa stazione
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

    try:
        risultati_query_1 = esegui_query(driver, query_1)
        stampa_risultati(
            "QUERY 1 - Percorso più breve tra Stazione Centrale e Ospedale Centrale",
            risultati_query_1
        )

        risultati_query_2 = esegui_query(driver, query_2)
        stampa_risultati(
            "QUERY 2 - Punti di interesse raggiungibili dalla Stazione Centrale",
            risultati_query_2
        )

    finally:
        driver.close()


if __name__ == "__main__":
    main()