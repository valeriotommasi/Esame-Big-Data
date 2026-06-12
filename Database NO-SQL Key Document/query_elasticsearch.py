from elasticsearch import Elasticsearch

# 1. Connessione a Elasticsearch
es = Elasticsearch(
    "https://localhost:9200",
    basic_auth=("elastic", "Solotop97"),
    verify_certs=False
)

indice = "recensioni_viaggi"

# 2. Elimino l'indice se esiste già
if es.indices.exists(index=indice):
    es.indices.delete(index=indice)

# 3. Creo l'indice
es.indices.create(index=indice)

# 4. Dati di esempio
recensioni = [
    {
        "cliente": "Marco Rossi",
        "destinazione": "Parigi",
        "nazione": "Francia",
        "valutazione": 5,
        "testo": "Viaggio bellissimo, hotel centrale e ottima organizzazione.",
        "prezzo": 849.80
    },
    {
        "cliente": "Giulia Bianchi",
        "destinazione": "Santorini",
        "nazione": "Grecia",
        "valutazione": 4,
        "testo": "Mare stupendo e hotel molto curato.",
        "prezzo": 1299.90
    },
    {
        "cliente": "Luca Verdi",
        "destinazione": "Berlino",
        "nazione": "Germania",
        "valutazione": 2,
        "testo": "Il programma era interessante, ma l'organizzazione non è stata buona.",
        "prezzo": 699.90
    }
]

# 5. Inserisco le recensioni
for i, recensione in enumerate(recensioni, start=1):
    es.index(index=indice, id=i, document=recensione)

# Rendo subito disponibili i documenti per la ricerca
es.indices.refresh(index=indice)

print("Indice creato e recensioni inserite correttamente.")


# QUERY 1 - Mostrare tutte le recensioni____________________________________
risultati = es.search(
    index=indice,
    query={"match_all": {}}
)

print("\nTUTTE LE RECENSIONI:")
for risultato in risultati["hits"]["hits"]:
    recensione = risultato["_source"]
    print(recensione)


# QUERY 2 - Cercare recensioni che parlano di hotel__________________________
risultati = es.search(
    index=indice,
    query={
        "match": {
            "testo": "hotel"
        }
    }
)

print("\nRECENSIONI CHE PARLANO DI HOTEL:")
for risultato in risultati["hits"]["hits"]:
    recensione = risultato["_source"]
    print(recensione)


# QUERY 3 - Cercare recensioni negative_____________________________________
risultati = es.search(
    index=indice,
    query={
        "range": {
            "valutazione": {
                "lte": 2 #minore o uguale
            }
        }
    }
)

print("\nRECENSIONI NEGATIVE:")
for risultato in risultati["hits"]["hits"]:
    recensione = risultato["_source"]
    print(recensione)