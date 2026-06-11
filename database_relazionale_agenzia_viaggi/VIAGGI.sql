CREATE TABLE CLIENTI (
    id_cliente INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR NOT NULL,
    cognome VARCHAR NOT NULL,
    email VARCHAR NOT NULL UNIQUE,
    telefono VARCHAR NOT NULL,
    citta VARCHAR NOT NULL
);

CREATE TABLE DESTINAZIONI (
    id_destinazione INTEGER PRIMARY KEY,
    citta VARCHAR NOT NULL,
    nazione VARCHAR NOT NULL,
    descrizione_turistica TEXT NOT NULL
);

CREATE TABLE HOTEL (
    id_hotel INTEGER PRIMARY KEY,
    nome VARCHAR NOT NULL,
    categoria VARCHAR NOT NULL,
    localita VARCHAR NOT NULL
);

CREATE TABLE MEZZI_TRASPORTO (
    id_mezzo INTEGER PRIMARY KEY NOT NULL UNIQUE,
    tipo VARCHAR NOT NULL,
    descrizione TEXT
);

CREATE TABLE PACCHETTI_VIAGGIO (
    id_pacchetto INTEGER PRIMARY KEY AUTOINCREMENT,
    nome VARCHAR NOT NULL,
    descrizione TEXT NOT NULL,
    durata_in_giorni INTEGER NOT NULL,
    prezzo_base REAL NOT NULL,
    id_destinazione INTEGER NOT NULL,
    id_hotel INTEGER NOT NULL,
    id_mezzo INTEGER NOT NULL,
    FOREIGN KEY(id_destinazione) REFERENCES DESTINAZIONI(id_destinazione),
    FOREIGN KEY(id_hotel) REFERENCES HOTEL(id_hotel),
    FOREIGN KEY(id_mezzo) REFERENCES MEZZI_TRASPORTO(id_mezzo)
);

CREATE TABLE PRENOTAZIONI (
    id_prenotazione INTEGER PRIMARY KEY AUTOINCREMENT,
    data DATE NOT NULL,
    numero_di_partecipanti INTEGER NOT NULL,
    importo_complessivo REAL NOT NULL,
    id_cliente INTEGER NOT NULL,
    id_pacchetto INTEGER NOT NULL,
    FOREIGN KEY(id_cliente) REFERENCES CLIENTI(id_cliente),
    FOREIGN KEY(id_pacchetto) REFERENCES PACCHETTI_VIAGGIO(id_pacchetto)
);