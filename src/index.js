const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const routes = require('./controllers/routes.js');

app.use(
   bodyParser.urlencoded({ extended: false }),
   routes,
);

const port = process.env.PORT || 3000;

app.listen(port, () => {
   console.log(`PORT: ${port}`);
});