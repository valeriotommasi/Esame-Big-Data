CREATE CONSTRAINT fermata_nome_unique IF NOT EXISTS
FOR (f:Fermata)
REQUIRE f.nome IS UNIQUE;

CREATE CONSTRAINT linea_codice_unique IF NOT EXISTS
FOR (l:Linea)
REQUIRE l.codice IS UNIQUE;

CREATE CONSTRAINT punto_interesse_nome_unique IF NOT EXISTS
FOR (p:PuntoInteresse)
REQUIRE p.nome IS UNIQUE;