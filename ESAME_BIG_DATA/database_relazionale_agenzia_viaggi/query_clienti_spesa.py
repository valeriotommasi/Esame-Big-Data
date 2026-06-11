"""trovare i clienti che hanno speso di più"""

import sqlite3
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent
DATABASE = BASE_DIR / "VIAGGI.db"

connessione = sqlite3.connect(DATABASE)
cursore = connessione.cursor()

query = """
SELECT 
    c.id_cliente,
    c.nome,
    c.cognome,
    c.email,
    SUM(p.importo_complessivo) AS totale_speso,
    COUNT(p.id_prenotazione) AS numero_prenotazioni
FROM CLIENTI c
JOIN PRENOTAZIONI p 
    ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nome, c.cognome, c.email
ORDER BY totale_speso DESC;
"""

cursore.execute(query)

risultati = cursore.fetchall()

for riga in risultati:
    print(riga)

connessione.close()