var express = require("express"),
tuio = require("tuio"),

app = express.createServer();
app.use(express["static"](__dirname + "/../"));
app.listen(5001);

tuio.init({
	oscPort: 3334,
	oscHost: "0.0.0.0",
	socketPort: app
});
