# Database Relazionale - Agenzia Viaggi

Questo database relazionale modella il sistema informativo di un'agenzia viaggi.

## Obiettivo

L'agenzia vuole gestire clienti, pacchetti viaggio, destinazioni, hotel, mezzi di trasporto e prenotazioni.

## Tabelle principali

- `CLIENTI`
- `DESTINAZIONI`
- `HOTEL`
- `MEZZI_TRASPORTO`
- `PACCHETTI_VIAGGIO`
- `PRENOTAZIONI`

## Query implementate

Gli scriptPython eseguono alcune query sul database:

1. query_viaggi_destinazioni -> Elencare tutte le prenotazioni relative a una certa destinazione.
2. query_clienti_spesa -> Trovare i clienti che hanno speso di più.
3. query_elenco_numpre -> Calcolare statistiche sulle prenotazioni per destinazione.

## Esecuzione

Per eseguire lo script:

```bash
python "nome_script".py
