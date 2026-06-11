// RELAZIONE COLLEGATE_A

MATCH (a:Fermata {nome: "Stazione Centrale"}), 
      (b:Fermata {nome: "Piazza Garibaldi"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 4, distanza_km: 0.8}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 4, distanza_km: 0.8}]->(a);

MATCH (a:Fermata {nome: "Piazza Garibaldi"}), 
      (b:Fermata {nome: "Piazza Duomo"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 3, distanza_km: 0.6}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 3, distanza_km: 0.6}]->(a);

MATCH (a:Fermata {nome: "Piazza Duomo"}), 
      (b:Fermata {nome: "Università"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 5, distanza_km: 1.0}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 5, distanza_km: 1.0}]->(a);

MATCH (a:Fermata {nome: "Università"}), 
      (b:Fermata {nome: "Ospedale Centrale"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 7, distanza_km: 1.5}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 7, distanza_km: 1.5}]->(a);

MATCH (a:Fermata {nome: "Ospedale Centrale"}), 
      (b:Fermata {nome: "Parco Nord"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 6, distanza_km: 1.3}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 6, distanza_km: 1.3}]->(a);

MATCH (a:Fermata {nome: "Stazione Centrale"}), 
      (b:Fermata {nome: "Porto"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 8, distanza_km: 2.0}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 8, distanza_km: 2.0}]->(a);

MATCH (a:Fermata {nome: "Porto"}), 
      (b:Fermata {nome: "Aeroporto"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 15, distanza_km: 7.5}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 15, distanza_km: 7.5}]->(a);

MATCH (a:Fermata {nome: "Piazza Garibaldi"}), 
      (b:Fermata {nome: "Stadio"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 9, distanza_km: 2.4}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 9, distanza_km: 2.4}]->(a);

MATCH (a:Fermata {nome: "Piazza Duomo"}), 
      (b:Fermata {nome: "Museo Civico"})
CREATE (a)-[:COLLEGATA_A {durata_minuti: 2, distanza_km: 0.4}]->(b),
       (b)-[:COLLEGATA_A {durata_minuti: 2, distanza_km: 0.4}]->(a);


// RELAZIONE SERVE

MATCH (l:Linea {codice: "M1"}), 
      (f:Fermata {nome: "Stazione Centrale"})
CREATE (l)-[:SERVE {ordine: 1}]->(f);

MATCH (l:Linea {codice: "M1"}), 
      (f:Fermata {nome: "Piazza Garibaldi"})
CREATE (l)-[:SERVE {ordine: 2}]->(f);

MATCH (l:Linea {codice: "M1"}), 
      (f:Fermata {nome: "Piazza Duomo"})
CREATE (l)-[:SERVE {ordine: 3}]->(f);

MATCH (l:Linea {codice: "M1"}), 
      (f:Fermata {nome: "Università"})
CREATE (l)-[:SERVE {ordine: 4}]->(f);

MATCH (l:Linea {codice: "B12"}), 
      (f:Fermata {nome: "Università"})
CREATE (l)-[:SERVE {ordine: 1}]->(f);

MATCH (l:Linea {codice: "B12"}), 
      (f:Fermata {nome: "Ospedale Centrale"})
CREATE (l)-[:SERVE {ordine: 2}]->(f);

MATCH (l:Linea {codice: "B12"}), 
      (f:Fermata {nome: "Parco Nord"})
CREATE (l)-[:SERVE {ordine: 3}]->(f);

MATCH (l:Linea {codice: "B27"}), 
      (f:Fermata {nome: "Piazza Garibaldi"})
CREATE (l)-[:SERVE {ordine: 1}]->(f);

MATCH (l:Linea {codice: "B27"}), 
      (f:Fermata {nome: "Stadio"})
CREATE (l)-[:SERVE {ordine: 2}]->(f);

MATCH (l:Linea {codice: "T3"}), 
      (f:Fermata {nome: "Stazione Centrale"})
CREATE (l)-[:SERVE {ordine: 1}]->(f);

MATCH (l:Linea {codice: "T3"}), 
      (f:Fermata {nome: "Porto"})
CREATE (l)-[:SERVE {ordine: 2}]->(f);

MATCH (l:Linea {codice: "T3"}), 
      (f:Fermata {nome: "Aeroporto"})
CREATE (l)-[:SERVE {ordine: 3}]->(f);


//RELAZIONE VICINO A

MATCH (p:PuntoInteresse {nome: "Università Centrale"}), 
      (f:Fermata {nome: "Università"})
CREATE (p)-[:VICINO_A {distanza_metri: 200}]->(f);

MATCH (p:PuntoInteresse {nome: "Ospedale San Marco"}), 
      (f:Fermata {nome: "Ospedale Centrale"})
CREATE (p)-[:VICINO_A {distanza_metri: 150}]->(f);

MATCH (p:PuntoInteresse {nome: "Museo Archeologico"}), 
      (f:Fermata {nome: "Museo Civico"})
CREATE (p)-[:VICINO_A {distanza_metri: 100}]->(f);

MATCH (p:PuntoInteresse {nome: "Stadio Comunale"}), 
      (f:Fermata {nome: "Stadio"})
CREATE (p)-[:VICINO_A {distanza_metri: 250}]->(f);

MATCH (p:PuntoInteresse {nome: "Porto Turistico"}), 
      (f:Fermata {nome: "Porto"})
CREATE (p)-[:VICINO_A {distanza_metri: 300}]->(f);

MATCH (p:PuntoInteresse {nome: "Aeroporto Civile"}), 
      (f:Fermata {nome: "Aeroporto"})
CREATE (p)-[:VICINO_A {distanza_metri: 400}]->(f);