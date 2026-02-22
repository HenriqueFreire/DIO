import app from "./app";

const port: number = parseInt(process.env.PORT || "5000", 10);

app.listen(port, () =>
  console.log(`Server listening on port ${port}`)
)