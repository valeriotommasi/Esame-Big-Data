# Database NoSQL documentale - Elasticsearch

## Descrizione 

Per questo progetto è stato scelto di modellare un archivio di **recensioni di pacchetti viaggio**, in continuazione contestuale al db SQL sull'agenzia di viaggio.

Ogni documento rappresenta una recensione lasciata da un cliente.

Esempio di documento:

```json
{
  "cliente": "Marco Rossi",
  "destinazione": "Parigi",
  "nazione": "Francia",
  "valutazione": 5,
  "testo": "Viaggio bellissimo, hotel centrale e ottima organizzazione.",
  "prezzo": 849.80
}
```

Questa scelta è adatta a Elasticsearch perché permette di fare ricerche testuali e filtri sui documenti.

---

## Perché usare Elasticsearch

A differenza di un database relazionale, non lavora principalmente con tabelle e join, ma con documenti JSON.

Nel progetto:

```text
indice Elasticsearch = recensioni_viaggi
singolo documento = una recensione
campo del documento = cliente, destinazione, valutazione, testo, prezzo, ecc.
```

---

## Script Python Elasticsearch

Lo script svolge queste operazioni:

1. si collega a Elasticsearch locale;
2. elimina l'indice `recensioni_viaggi` se esiste già;
3. crea l'indice `recensioni_viaggi`;
4. inserisce alcuni documenti di esempio;
5. esegue tre query;
6. stampa i risultati.

---


## Credenziali Elasticsearch

Per sicurezza, la password non dovrebbe essere salvata direttamente nello script ne essere caricata su GitHub.

---

## Query Elasticsearch implementate

### Query 1 - Mostrare tutte le recensioni

```python
risultati = es.search(
    index=indice,
    query={"match_all": {}}
)
```

Questa query usa `match_all`, quindi restituisce tutti i documenti presenti nell'indice.

Serve a verificare che i documenti siano stati inseriti correttamente.

---

### Query 2 - Cercare recensioni che parlano di hotel

```python
risultati = es.search(
    index=indice,
    query={
        "match": {
            "testo": "hotel"
        }
    }
)
```

Questa query usa `match`, che permette di cercare una parola dentro un campo testuale.

In questo caso cerca la parola `hotel` nel campo `testo`.

Serve a rispondere alla domanda:

> Quali recensioni parlano di hotel?

---

### Query 3 - Cercare recensioni negative

```python
risultati = es.search(
    index=indice,
    query={
        "range": {
            "valutazione": {
                "lte": 2
            }
        }
    }
)
```

Questa query usa `range`, cioè un filtro su un intervallo di valori.

Il campo filtrato è `valutazione`.

La condizione:

```text
lte: 2
```

significa:

```text
less than or equal to 2
```

cioè:

```text
minore o uguale a 2
```

Serve quindi a trovare le recensioni negative.

---

