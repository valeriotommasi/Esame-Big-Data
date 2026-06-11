# Database a Grafo Neo4j - Mobilità Urbana

## Descrizione del progetto

Questo progetto realizza un database NoSQL a grafo tramite **Neo4j** per modellare una rete di mobilità urbana.

La traccia richiede di rappresentare una città attraverso fermate di autobus, treno e metropolitana, linee di trasporto, tratte tra fermate e punti di interesse collegati alle fermate più vicine.

---

## Traccia di riferimento

Una città vuole modellare la propria rete di mobilità come un grafo.

Le fermate di autobus, treno e metropolitana devono essere rappresentate con nome, zona e coordinate.

Le linee di trasporto hanno codice, tipologia e operatore.

Le fermate sono collegate tra loro da tratte, che hanno una durata media e una distanza.

Le linee servono specifiche fermate in un certo ordine.

Inoltre alcuni punti di interesse della città, come università, ospedali e stazioni, devono essere collegati alle fermate più vicine.

Il sistema deve consentire di studiare percorsi, cambi di linea e accessibilità dei punti di interesse.

---

## Obiettivo del database

Il database ha l'obiettivo di rappresentare una rete di mobilità urbana e consentire interrogazioni relative a:

* percorsi tra fermate;
* collegamenti tra fermate;
* linee di trasporto che servono determinate fermate;
* punti di interesse raggiungibili dalla rete urbana;
* accessibilità dei luoghi principali della città.

---

## Modello del grafo

Il modello del grafo è composto da tre tipologie principali di nodi:

* `Fermata`
* `Linea`
* `PuntoInteresse`

e da tre tipologie principali di relazioni:

* `COLLEGATA_A`
* `SERVE`
* `VICINO_A`

---

## Nodi

### Fermata

I nodi `Fermata` rappresentano le fermate della rete urbana.

Proprietà principali:

* `nome`
* `zona`
* `latitudine`
* `longitudine`
* `tipo`

Esempio:

```cypher
(:Fermata {
    nome: "Stazione Centrale",
    zona: "Centro",
    latitudine: 41.125,
    longitudine: 16.866,
    tipo: "treno"
})
```

---

### Linea

I nodi `Linea` rappresentano le linee di trasporto urbano.

Proprietà principali:

* `codice`
* `tipologia`
* `operatore`

Esempio:

```cypher
(:Linea {
    codice: "M1",
    tipologia: "metropolitana",
    operatore: "MetroCity"
})
```

---

### PuntoInteresse

I nodi `PuntoInteresse` rappresentano luoghi rilevanti della città, come università, ospedali, musei, stazioni o aeroporti.

Proprietà principali:

* `nome`
* `categoria`
* `descrizione`

Esempio:

```cypher
(:PuntoInteresse {
    nome: "Università Centrale",
    categoria: "università",
    descrizione: "Polo universitario principale della città"
})
```

---

## Relazioni

### COLLEGATA_A

La relazione `COLLEGATA_A` collega due fermate e rappresenta una tratta della rete urbana.

Proprietà principali:

* `durata_minuti`
* `distanza_km`

Esempio:

```cypher
(:Fermata)-[:COLLEGATA_A {
    durata_minuti: 4,
    distanza_km: 0.8
}]->(:Fermata)
```

Nel progetto le relazioni `COLLEGATA_A` sono state create in entrambe le direzioni, così da rappresentare tratte percorribili sia in andata sia in ritorno.

---

### SERVE

La relazione `SERVE` collega una linea di trasporto alle fermate servite.

Proprietà principali:

* `ordine`

Esempio:

```cypher
(:Linea)-[:SERVE {ordine: 1}]->(:Fermata)
```

La proprietà `ordine` indica la posizione della fermata all'interno della linea.

---

### VICINO_A

La relazione `VICINO_A` collega un punto di interesse alla fermata più vicina.

Proprietà principali:

* `distanza_metri`

Esempio:

```cypher
(:PuntoInteresse)-[:VICINO_A {
    distanza_metri: 200
}]->(:Fermata)
```

Questa relazione permette di individuare quali punti di interesse sono accessibili attraverso la rete di trasporto.

---

## Struttura del progetto

La cartella del progetto è organizzata nel seguente modo:

```text
database_grafo_neo4j_mobilita/
│
├── cypher/
│   ├── 01_create_constraints.cypher
│   ├── 02_create_nodes.cypher
│   ├── 03_create_relationships.cypher
│   └── 04_queries.cypher
│
├── python/
│   └── query_mobilita_neo4j.py
│
└── README.md
```

---

## Descrizione dei file

### 01_create_constraints.cypher

Contiene i vincoli di unicità del database.

Sono stati creati vincoli per evitare duplicati su:

* `Fermata.nome`
* `Linea.codice`
* `PuntoInteresse.nome`

Le constraint aiutano a mantenere il grafo coerente, evitando la creazione di nodi duplicati con lo stesso identificativo logico.

---

### 02_create_nodes.cypher

Contiene la creazione dei nodi principali del grafo:

* fermate;
* linee di trasporto;
* punti di interesse.

---

### 03_create_relationships.cypher

Contiene la creazione delle relazioni tra i nodi:

* collegamenti tra fermate tramite `COLLEGATA_A`;
* collegamenti tra linee e fermate tramite `SERVE`;
* collegamenti tra punti di interesse e fermate tramite `VICINO_A`.

---

### 04_queries.cypher

Contiene le query principali richieste dalla traccia.

Le query implementate sono:

1. ricerca del percorso più breve tra due fermate;
2. individuazione dei punti di interesse raggiungibili da una certa stazione.

---

### query_mobilita_neo4j.py

Contiene lo script Python che si collega al database Neo4j ed esegue le query principali tramite il driver ufficiale Neo4j per Python.

---

## Query implementate

### Query 1 - Percorso più breve tra due fermate

La prima query permette di trovare il percorso più breve tra due fermate della rete urbana.

Nel progetto viene cercato il percorso più breve tra:

* `Stazione Centrale`
* `Ospedale Centrale`

Query:

```cypher
MATCH percorso = shortestPath(
    (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*]-(arrivo:Fermata {nome: "Ospedale Centrale"})
)
RETURN percorso;
```

Questa query utilizza la funzione `shortestPath` di Neo4j e attraversa le relazioni `COLLEGATA_A` tra le fermate.

---

### Query 2 - Punti di interesse raggiungibili da una certa stazione

La seconda query individua i punti di interesse raggiungibili partendo dalla `Stazione Centrale`.

La query attraversa fino a 6 tratte della rete urbana e restituisce i punti di interesse collegati alle fermate raggiunte.

Query:

```cypher
MATCH percorso = (partenza:Fermata {nome: "Stazione Centrale"})-[:COLLEGATA_A*1..6]-(fermata:Fermata)
MATCH (poi:PuntoInteresse)-[v:VICINO_A]->(fermata)
RETURN DISTINCT 
    poi.nome AS punto_interesse,
    poi.categoria AS categoria,
    fermata.nome AS fermata_vicina,
    length(percorso) AS numero_tratte,
    v.distanza_metri AS distanza_dalla_fermata
ORDER BY numero_tratte;
```

La query restituisce:

* nome del punto di interesse;
* categoria del punto di interesse;
* fermata più vicina;
* numero di tratte necessarie per raggiungere la fermata;
* distanza tra il punto di interesse e la fermata.

Questa query permette di analizzare l'accessibilità dei luoghi principali della città a partire da una fermata centrale.

---

## Tecnologie utilizzate

* Neo4j
* Cypher
* Python
* Driver ufficiale Neo4j per Python


---

## Configurazione dello script Python

Nel file `python/query_mobilita_neo4j.py` devono essere impostati i dati di connessione al database Neo4j.

Esempio:

```python
URI = "bolt://127.0.0.1:7687"
USERNAME = "neo4j"
PASSWORD = "che_la_forza_sia_con_te"
```

La password deve corrispondere a quella impostata nel database Neo4j locale.

---

## Esecuzione del progetto

### 1. Avviare Neo4j

Avviare il database tramite Neo4j Desktop.

---

### 2. Eseguire gli script Cypher

Eseguire gli script Cypher nel seguente ordine:

```text
01_create_constraints.cypher
02_create_nodes.cypher
03_create_relationships.cypher
04_queries.cypher
```

Gli script possono essere eseguiti direttamente da Neo4j Browser.

---

### 3. Eseguire lo script Python

Dal terminale, posizionarsi nella cartella principale del progetto ed eseguire:

```bash
python python/query_mobilita_neo4j.py
```

Lo script stamperà a schermo i risultati delle query implementate.

Attraverso le query Cypher è possibile analizzare percorsi e accessibilità, mostrando l'efficacia dei database a grafo in scenari in cui i collegamenti tra entità sono centrali.
