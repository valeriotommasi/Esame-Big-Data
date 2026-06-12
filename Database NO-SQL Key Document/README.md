# Progetto esame Big Data

Questo repository contiene il progetto sviluppato per l'esame di Big Data.

Il progetto prevede lo sviluppo di esempi di database differenti:

1. **Database relazionale SQL**: gestione di un'agenzia viaggi.
2. **Database NoSQL documentale con Elasticsearch**: gestione e interrogazione di recensioni di pacchetti viaggio.
3. **Database NoSQL a grafo con Neo4j**: da sviluppare successivamente.

---

## Struttura del repository

```text
big_data_esame_valerio/
│
├── agenzia_viaggi_sql/
│   ├── database/
│   │   ├── schema.sql
│   │   ├── VIAGGI.sqlite
│   │   ├── clienti_agenzia_viaggi.csv
│   │   ├── destinazioni_agenzia_viaggi.csv
│   │   ├── hotel_agenzia_viaggi.csv
│   │   ├── mezzi_trasporto_agenzia_viaggi.csv
│   │   ├── pacchetti_viaggio_agenzia_viaggi_1000.csv
│   │   └── prenotazioni_agenzia_viaggi_1000.csv
│   │
│   └── python/
│       └── query_agenzia_viaggi_sql.py
│
├── elastic_recensioni_viaggi/
│   ├── .env.example
│   └── python/
│       └── recensioni_viaggi_elasticsearch.py
│
├── requirements.txt
├── .gitignore
└── README.md
```

---

# 1. Database relazionale SQL - Agenzia viaggi

## Descrizione della traccia

Il database relazionale modella il funzionamento di un'agenzia viaggi che vende pacchetti turistici.

Il sistema gestisce:

- clienti;
- destinazioni;
- hotel;
- mezzi di trasporto;
- pacchetti viaggio;
- prenotazioni.

Ogni cliente può effettuare una o più prenotazioni. Ogni prenotazione riguarda un pacchetto viaggio. Ogni pacchetto è collegato a una destinazione, a un hotel e a un mezzo di trasporto.

---

## Tabelle principali

### CLIENTI

Contiene i dati anagrafici dei clienti.

Campi principali:

- `id_cliente`
- `nome`
- `cognome`
- `email`
- `telefono`
- `citta`

### DESTINAZIONI

Contiene le destinazioni turistiche disponibili.

Campi principali:

- `id_destinazione`
- `citta`
- `nazione`
- `descrizione_turistica`

### HOTEL

Contiene gli hotel collegati ai pacchetti viaggio.

Campi principali:

- `id_hotel`
- `nome`
- `categoria`
- `localita`

### MEZZI_TRASPORTO

Contiene i mezzi di trasporto previsti dai pacchetti.

Campi principali:

- `id_mezzo`
- `tipo`
- `descrizione`

### PACCHETTI_VIAGGIO

Contiene i pacchetti turistici venduti dall'agenzia.

Campi principali:

- `id_pacchetto`
- `nome`
- `descrizione`
- `durata_in_giorni`
- `prezzo_base`
- `id_destinazione`
- `id_hotel`
- `id_mezzo`

### PRENOTAZIONI

Contiene le prenotazioni effettuate dai clienti.

Campi principali:

- `id_prenotazione`
- `data`
- `numero_di_partecipanti`
- `importo_complessivo`
- `id_cliente`
- `id_pacchetto`

---

## Query SQL implementate

Lo script `query_agenzia_viaggi_sql.py` esegue due query principali.

### Query 1 - Prenotazioni per destinazione

Questa query elenca tutte le prenotazioni relative a una certa destinazione.

Nel codice la destinazione usata come esempio è:

```python
destinazione = "Roma"
```

La query collega le tabelle:

- `PRENOTAZIONI`
- `CLIENTI`
- `PACCHETTI_VIAGGIO`
- `DESTINAZIONI`

Serve a rispondere alla domanda:

> Quali prenotazioni sono state effettuate per una certa destinazione?

### Query 2 - Clienti che hanno speso di più

Questa query calcola il totale speso da ogni cliente sommando gli importi delle sue prenotazioni.

La query usa:

```sql
SUM(p.importo_complessivo)
```

per calcolare la spesa totale e:

```sql
ORDER BY totale_speso DESC
```

per ordinare i clienti da chi ha speso di più a chi ha speso di meno.

---

## Come eseguire lo script SQL

Aprire il terminale nella cartella:

```text
agenzia_viaggi_sql/python
```

Eseguire:

```bash
python query_agenzia_viaggi_sql.py
```

Lo script si collega al database SQLite `VIAGGI.sqlite` e stampa i risultati delle query.

---

# 2. Database NoSQL documentale - Elasticsearch

## Descrizione del caso d'uso

Il database Elasticsearch è a traccia libera. Per questo progetto è stato scelto di modellare un archivio di **recensioni di pacchetti viaggio**.

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

Elasticsearch è un database NoSQL orientato ai documenti.

A differenza di un database relazionale, non lavora principalmente con tabelle e join, ma con documenti JSON.

Nel progetto:

```text
indice Elasticsearch = recensioni_viaggi
singolo documento = una recensione
campo del documento = cliente, destinazione, valutazione, testo, prezzo, ecc.
```

---

## Script Python Elasticsearch

Lo script si trova in:

```text
elastic_recensioni_viaggi/python/recensioni_viaggi_elasticsearch.py
```

Lo script svolge queste operazioni:

1. si collega a Elasticsearch locale;
2. elimina l'indice `recensioni_viaggi` se esiste già;
3. crea l'indice `recensioni_viaggi`;
4. inserisce alcuni documenti di esempio;
5. esegue tre query;
6. stampa i risultati.

---

## Installazione dipendenze Python

Dalla cartella principale del repository eseguire:

```bash
pip install -r requirements.txt
```

Il file `requirements.txt` contiene:

```text
elasticsearch
```

---

## Avvio di Elasticsearch

Per eseguire lo script è necessario avere Elasticsearch avviato sul proprio computer.

Su Windows, aprire un terminale nella cartella `bin` di Elasticsearch, per esempio:

```powershell
cd C:\Users\ilary\OneDrive\Desktop\elastic\elasticsearch-9.4.2\bin
```

Poi avviare Elasticsearch:

```powershell
.\elasticsearch.bat
```

Il terminale deve rimanere aperto, perché se viene chiuso Elasticsearch si spegne.

---

## Credenziali Elasticsearch

Per sicurezza, la password non viene salvata direttamente nello script e non deve essere caricata su GitHub.

Lo script legge la password dalla variabile d'ambiente:

```text
ELASTIC_PASSWORD
```

È presente un file di esempio:

```text
elastic_recensioni_viaggi/.env.example
```

che mostra quali variabili servono:

```text
ELASTIC_URL=https://localhost:9200
ELASTIC_USER=elastic
ELASTIC_PASSWORD=inserisci_qui_la_tua_password
```

---

## Impostare la password su Windows PowerShell

Prima di eseguire lo script, impostare la password nel terminale:

```powershell
$env:ELASTIC_PASSWORD="LA_TUA_PASSWORD_ELASTICSEARCH"
```

Poi entrare nella cartella dello script:

```powershell
cd elastic_recensioni_viaggi\python
```

Ed eseguire:

```powershell
python recensioni_viaggi_elasticsearch.py
```

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

# 3. Comandi GitHub

## Creare il repository locale

Dalla cartella principale del progetto:

```bash
git init
git add .
git commit -m "Primo caricamento progetto Big Data"
```

---

## Collegare il repository remoto GitHub

Dopo aver creato un repository vuoto su GitHub, copiare il link HTTPS del repository e usare:

```bash
git remote add origin https://github.com/TUO_USERNAME/NOME_REPOSITORY.git
git branch -M main
git push -u origin main
```

Esempio:

```bash
git remote add origin https://github.com/valerio/progetto-big-data.git
git branch -M main
git push -u origin main
```

---

# 4. Note finali

Il progetto dimostra la capacità di:

- progettare un database relazionale;
- implementare tabelle SQL e relazioni tramite chiavi esterne;
- popolare il database con dati di esempio;
- interrogare un database SQL tramite Python;
- creare e interrogare un indice Elasticsearch;
- usare query documentali e testuali in Elasticsearch;
- organizzare il lavoro in una struttura adatta al caricamento su GitHub.

La parte Neo4j verrà aggiunta successivamente in una cartella dedicata.
