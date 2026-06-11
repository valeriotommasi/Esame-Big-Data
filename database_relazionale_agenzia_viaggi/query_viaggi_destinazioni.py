"""ELENCARE TUTTE LE PRENOTAZIONI RELATIVE A UNA DESTINAZIONE"""

import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DATABASE = BASE_DIR/"VIAGGI.db"

connessione = sqlite3.connect(DATABASE)
cursore = connessione.cursor()


query = """
SELECT 
    p.id_prenotazione,
    p.data,
    c.nome,
    c.cognome,
    d.citta AS destinazione,
    pv.nome AS pacchetto,
    p.numero_di_partecipanti,
    p.importo_complessivo
FROM PRENOTAZIONI p
JOIN CLIENTI c 
    ON p.id_cliente = c.id_cliente
JOIN PACCHETTI_VIAGGIO pv 
    ON p.id_pacchetto = pv.id_pacchetto
JOIN DESTINAZIONI d 
    ON pv.id_destinazione = d.id_destinazione
WHERE d.citta = "Roma";
"""

cursore.execute(query)

risultati = cursore.fetchall()

for riga in risultati:
    print(riga)

connessione.close()