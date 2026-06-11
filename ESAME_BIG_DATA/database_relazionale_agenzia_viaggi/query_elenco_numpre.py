""""Per ogni destinazione, mostrare quante prenotazioni sono 
state effettuate, il numero totale di partecipanti e 
l’importo medio delle prenotazioni."""

import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DATABASE = BASE_DIR / "VIAGGI.db"

connessione = sqlite3.connect(DATABASE)
cursore = connessione.cursor()

query = """
SELECT
 d.citta,
 d.nazione,
 COUNT(p.id_prenotazione) AS numero_prenotazioni,
 SUM(p.numero_di_partecipanti) AS totale_partecipanti,
 ROUND(AVG(p.importo_complessivo),2) AS importo_medio
 FROM PRENOTAZIONI p 
 JOIN PACCHETTI_VIAGGIO pv 
 	ON p.id_pacchetto =pv.id_pacchetto 
 JOIN DESTINAZIONI d 
 	ON pv.id_destinazione =d.id_destinazione 
 GROUP BY d.citta
 ORDER BY numero_prenotazioni DESC
"""

cursore.execute(query)

risultati = cursore.fetchall()

for riga in risultati:
    print(riga)

connessione.close()