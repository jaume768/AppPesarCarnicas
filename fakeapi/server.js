const jsonServer = require('json-server');
const server = jsonServer.create();
const router = jsonServer.router('db.json');
const middlewares = jsonServer.defaults();
const port = 3000;

// Middleware predeterminados
server.use(middlewares);

// Middleware para manejar solicitudes POST con validación del body
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

server.post('/getArticleWeight', (req, res) => {
  const articleId = req.body.id;
  if (!articleId) {
    return res.status(400).send('Invalid body');
  }

  res.jsonp({ pes: 3.38 });
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
