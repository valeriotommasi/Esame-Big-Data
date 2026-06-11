// NODI FERMATA

CREATE 
(:Fermata {
    nome: "Stazione Centrale",
    zona: "Centro",
    latitudine: 41.125,
    longitudine: 16.866,
    tipo: "treno"
}),
(:Fermata {
    nome: "Piazza Garibaldi",
    zona: "Centro",
    latitudine: 41.126,
    longitudine: 16.870,
    tipo: "bus"
}),
(:Fermata {
    nome: "Piazza Duomo",
    zona: "Centro",
    latitudine: 41.127,
    longitudine: 16.872,
    tipo: "metro"
}),
(:Fermata {
    nome: "Università",
    zona: "Centro",
    latitudine: 41.128,
    longitudine: 16.875,
    tipo: "metro"
}),
(:Fermata {
    nome: "Ospedale Centrale",
    zona: "Nord",
    latitudine: 41.133,
    longitudine: 16.880,
    tipo: "bus"
}),
(:Fermata {
    nome: "Porto",
    zona: "Est",
    latitudine: 41.135,
    longitudine: 16.885,
    tipo: "bus"
}),
(:Fermata {
    nome: "Aeroporto",
    zona: "Periferia",
    latitudine: 41.140,
    longitudine: 16.890,
    tipo: "treno"
}),
(:Fermata {
    nome: "Stadio",
    zona: "Ovest",
    latitudine: 41.130,
    longitudine: 16.860,
    tipo: "bus"
}),
(:Fermata {
    nome: "Museo Civico",
    zona: "Centro",
    latitudine: 41.129,
    longitudine: 16.871,
    tipo: "metro"
}),
(:Fermata {
    nome: "Parco Nord",
    zona: "Nord",
    latitudine: 41.138,
    longitudine: 16.878,
    tipo: "bus"
});


//NODI LINEE

CREATE 
(:Linea {
    codice: "M1",
    tipologia: "metropolitana",
    operatore: "MetroCity"
}),
(:Linea {
    codice: "B12",
    tipologia: "autobus",
    operatore: "BusCity"
}),
(:Linea {
    codice: "B27",
    tipologia: "autobus",
    operatore: "BusCity"
}),
(:Linea {
    codice: "T3",
    tipologia: "treno urbano",
    operatore: "RailCity"
});


//NODI PUNTI DI INTERESSE

CREATE
(:PuntoInteresse {
    nome: "Università Centrale",
    categoria: "università",
    descrizione: "Polo universitario principale della città"
}),
(:PuntoInteresse {
    nome: "Ospedale San Marco",
    categoria: "ospedale",
    descrizione: "Grande struttura ospedaliera cittadina"
}),
(:PuntoInteresse {
    nome: "Museo Archeologico",
    categoria: "museo",
    descrizione: "Museo dedicato alla storia antica del territorio"
}),
(:PuntoInteresse {
    nome: "Stadio Comunale",
    categoria: "stadio",
    descrizione: "Impianto sportivo principale"
}),
(:PuntoInteresse {
    nome: "Porto Turistico",
    categoria: "stazione",
    descrizione: "Area portuale per collegamenti turistici"
}),
(:PuntoInteresse {
    nome: "Aeroporto Civile",
    categoria: "aeroporto",
    descrizione: "Aeroporto principale della città"
});