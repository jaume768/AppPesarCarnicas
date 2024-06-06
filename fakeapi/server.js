const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();
const port = 3000;

server.use(middlewares);

server.use(jsonServer.bodyParser);
server.use((req, res, next) => {
  if (req.method === 'POST') {
    switch (req.url) {
      case '/orderPreparation/configuration':
        if (JSON.stringify(req.body) !== '{}') {
          return res.status(400).send('Invalid body');
        }
        break;
      case '/orderPreparation/summaries':
        if (!req.body.productType || typeof req.body.butchery !== 'boolean') {
          return res.status(400).send('Invalid body');
        }
        break;
      case '/orderPreparation/productList':
        if (!req.body.productType || typeof req.body.butchery !== 'boolean' || !Array.isArray(req.body.summaries)) {
          return res.status(400).send('Invalid body');
        }
        break;
      default:
        break;
    }
  }
  next();
});



server.post('/updateArticleWeight', (req, res) => {
  const id = req.body.id;
  const weight = req.body.weight;
  const accumulatedWeightText = req.body.accumulatedWeightText;
  const clientCode = req.body.clientCode;

  if (!id || !weight || !clientCode || accumulatedWeightText === null) {
    return res.status(400).send('Invalid body');
  }

  res.jsonp({ message: "ok" });
});


server.post('/getArticleWeight', (req, res) => {
  const articleId = req.body.id;
  if (!articleId) {
    return res.status(400).send('Invalid body');
  }

  res.jsonp({ pes: 3.38 });
});


server.post('/getArticleList', (req, res) => {
  
  const productType = req.body.productType;
  if (!productType) {
    return res.status(400).send('Invalid body');
  }

  const articleList = {
    "articles": [
      {"code": 10313, "description": "ALAS POLLO FCO", "kgs": 34, "units": "", "boxes": "", "doc": ""},
      {"code": 10319, "description": "ALAS POLLO S/PUNTA P/MITAD FCA", "kgs": 4, "units": "", "boxes": "", "doc": ""},
      {"code": 10389, "description": "CADERA POLLO", "kgs": 40, "units": "", "boxes": "", "doc": ""},
      {"code": 10388, "description": "CARCARA POLLO", "kgs": 12, "units": 10, "boxes": "", "doc": ""},
      {"code": 10365, "description": "CONEJO Fco. CORTADO FONDO", "kgs": 4, "units": "", "boxes": 2, "doc": ""},
      {"code": 10360, "description": "CONEJO FRESCO", "kgs": 27, "units": "", "boxes": "", "doc": ""},
      {"code": 10363, "description": "CONEJO GRANDE + 1.5 KG FCO.", "kgs": 2, "units": "", "boxes": "", "doc": ""},
      {"code": 10362, "description": "CONEJO PEQ. 800-900 G", "kgs": 20, "units": "", "boxes": "", "doc": ""},
      {"code": 10395, "description": "CONFIT PATO 6U (KG)", "kgs": 2, "units": "", "boxes": "", "doc": ""},
      {"code": 10311, "description": "CONTRAMUSLO POLLO C/H. FCO.", "kgs": 2, "units": "", "boxes": "", "doc": ""},
      {"code": 11339, "description": "CONTRAMUSLO POLLO S/H S/P (X) FON", "kgs": 11, "units": "", "boxes": "", "doc": ""},
      {"code": 10310, "description": "PECHUGA POLLO", "kgs": 15, "units": 5, "boxes": "", "doc": ""},
      {"code": 10320, "description": "PIERNA POLLO", "kgs": 18, "units": "", "boxes": 3, "doc": ""},
      {"code": 10330, "description": "MUSLO POLLO", "kgs": 25, "units": "", "boxes": "", "doc": ""},
      {"code": 10340, "description": "ALA POLLO", "kgs": 8, "units": "", "boxes": "", "doc": ""},
      {"code": 10350, "description": "PATA POLLO", "kgs": 6, "units": 2, "boxes": "", "doc": ""},
      {"code": 10360, "description": "CUELLO POLLO", "kgs": 10, "units": "", "boxes": 1, "doc": ""},
      {"code": 10370, "description": "HIGADO POLLO", "kgs": 5, "units": "", "boxes": "", "doc": ""},
      {"code": 10380, "description": "MOLLEJA POLLO", "kgs": 3, "units": 1, "boxes": "", "doc": ""},
      {"code": 10390, "description": "CORAZON POLLO", "kgs": 7, "units": "", "boxes": "", "doc": ""}
    ]
  };

  res.jsonp(articleList);
});


// Rutas personalizadas
server.post('/orderPreparation/configuration', (req, res) => {
  res.jsonp({
    "printers": [
      {
        "id": 1,
        "name": "Impresora 1"
      },
      {
        "id": 2,
        "name": "Impresora 2"
      },
    ],
    "scales": [
      {
        "id": 1,
        "name": "Báscula 1"
      },
      {
        "id": 2,
        "name": "Báscula 2"
      }

    ]
  });
});

server.post('/orderPreparation/summaries', (req, res) => {
  const summaries = {
    "LAMB": [1, 2, 3, 4],
    "POULTRY": [1, 2, 3, 4, 5],
    "PIG": [1, 2, 3],
    "CHOPPED": [1, 2, 3]
  };
  res.jsonp({ "summaries": summaries[req.body.productType] || [] });
});

server.post('/orderPreparation/productList', (req, res) => {
  const productList = {
    "LAMB": [
      {
        "code": 1,
        "name": "Client 1",
        "articles": [
          {
            "id": 1,
            "code": 1,
            "name": "Article 1",
            "observation": "Observation 1",
            "units": 1.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 2,
            "code": 2,
            "name": "Article 2",
            "observation": "Observation 2",
            "units": 2.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 3,
            "code": 3,
            "name": "Article 3",
            "observation": "Observation 3",
            "units": 3.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 4,
            "code": 4,
            "name": "Article 4",
            "observation": "Observation 4",
            "units": 2.5,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 5,
            "code": 5,
            "name": "Article 5",
            "observation": "Observation 5",
            "units": 1.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          }
        ]
      }
    ],
    "POULTRY": [
      {
        "code": 2,
        "name": "Client 2",
        "articles": [
          {
            "id": 6,
            "code": 6,
            "name": "Article 6",
            "observation": "Observation 6",
            "units": 1.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 7,
            "code": 7,
            "name": "Article 7",
            "observation": "Observation 7",
            "units": 2.5,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 8,
            "code": 8,
            "name": "Article 8",
            "observation": "Observation 8",
            "units": 1.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 9,
            "code": 9,
            "name": "Article 9",
            "observation": "Observation 9",
            "units": 3.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 10,
            "code": 10,
            "name": "Article 10",
            "observation": "Observation 10",
            "units": 2.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 11,
            "code": 11,
            "name": "Article 11",
            "observation": "Observation 11",
            "units": 1.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 12,
            "code": 12,
            "name": "Article 12",
            "observation": "Observation 12",
            "units": 2.5,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 8,
            "code": 8,
            "name": "Article 8",
            "observation": "Observation 8",
            "units": 1.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 9,
            "code": 9,
            "name": "Article 9",
            "observation": "Observation 9",
            "units": 3.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 10,
            "code": 10,
            "name": "Article 10",
            "observation": "Observation 10",
            "units": 2.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 6,
            "code": 6,
            "name": "Article 6",
            "observation": "Observation 6",
            "units": 1.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 7,
            "code": 7,
            "name": "Article 7",
            "observation": "Observation 7",
            "units": 2.5,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 8,
            "code": 8,
            "name": "Article 8",
            "observation": "Observation 8",
            "units": 1.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 9,
            "code": 9,
            "name": "Article 9",
            "observation": "Observation 9",
            "units": 3.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 10,
            "code": 10,
            "name": "Article 10",
            "observation": "Observation 10",
            "units": 2.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          }
        ]
      }
    ],
    "PIG": [
      {
        "code": 3,
        "name": "Client 3",
        "articles": [
          {
            "id": 11,
            "code": 11,
            "name": "Article 11",
            "observation": "Observation 11",
            "units": 2.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 12,
            "code": 12,
            "name": "Article 12",
            "observation": "Observation 12",
            "units": 3.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 13,
            "code": 13,
            "name": "Article 13",
            "observation": "Observation 13",
            "units": 1.0,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 14,
            "code": 14,
            "name": "Article 14",
            "observation": "Observation 14",
            "units": 2.5,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 15,
            "code": 15,
            "name": "Article 15",
            "observation": "Observation 15",
            "units": 3.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          }
        ]
      }
    ],
    "CHOPPED": [
      {
        "code": 4,
        "name": "Client 4",
        "articles": [
          {
            "id": 16,
            "code": 16,
            "name": "Article 16",
            "observation": "Observation 16",
            "units": 1.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 17,
            "code": 17,
            "name": "Article 17",
            "observation": "Observation 17",
            "units": 2.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          // Nuevo artículo
          {
            "id": 19,
            "code": 19,
            "name": "Article 19",
            "observation": "Observation 19",
            "units": 3.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          }
        ]
      },
      // Nuevo cliente
      {
        "code": 5,
        "name": "Client 5",
        "articles": [
          {
            "id": 20,
            "code": 20,
            "name": "Article 20",
            "observation": "Observation 20",
            "units": 2.5,
            "unitType": "KILOS",
            "special": true,
            "mandatoryLot": false,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 21,
            "code": 21,
            "name": "Article 21",
            "observation": "Observation 21",
            "units": 1.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          },
          {
            "id": 22,
            "code": 22,
            "name": "Article 22",
            "observation": "Observation 22",
            "units": 1.0,
            "unitType": "KILOS",
            "special": false,
            "mandatoryLot": true,
            "primaryAction": null,
            "secondaryAction": null
          }
        ]
      }
    ]
  };  
  res.jsonp({ "clients": productList[req.body.productType] || [] });
});

server.post('/generateDecimal', (req, res) => {
  const generateRandomDecimal = () => {
    return (Math.random() * 100).toFixed(2);
  };

  const decimalNumber = generateRandomDecimal();
  res.jsonp({ "decimalNumber": decimalNumber });
});

server.post('/pesaje/zero', (req, res) => {
  res.jsonp({
    "id": 11,
    "pes": 0,
    "tipoPes": "ZERO",
    "taraBascula": false,
    "tara": {
        "total": 0
    }
  });
});

server.post('/pesaje/inestable', (req, res) => {
  res.jsonp({
    "id": 11,
    "pes": 1.46,
    "tipoPes": "INESTABLE",
    "taraBascula": false,
    "tara": {
        "total": 0
    }
  });
});

server.post('/pesaje/estable', (req, res) => {
  res.jsonp({
    "id": 11,
    "pes": 3.38,
    "tipoPes": "ESTABLE",
    "taraBascula": false,
    "tara": {
        "total": 0
    }
  });
});

// Usa el router predeterminado
server.use(router);

server.listen(port, () => {
  console.log(`JSON Server is running on http://localhost:${port}`);
});
