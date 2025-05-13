const express = require("express");
const path = require("path");
const app = express();
const port = 3000;
// Serve static files (index.html)
app.use(express.static(path.join(__dirname)));
app.listen(port, () => {
  console.log(`Mini WebApp listening at http://localhost:${port}`);
});