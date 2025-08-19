import fastify from "fastify";
import cors from "@fastify/cors";

const server = fastify({
  logger: true,
});

server.register(cors, {
  origin: "*",
  methods: ["GET"],
});

const teams = [
  { id: 1, name: "Ferrari", base: "Maranello, IT", engine: "Ferrari", founded: 1929},
  { id: 2, name: "McLaren", base: "Woking, UK", engine: "Mercedes", founded: 1963 },
  { id: 3, name: "Mercedes", base: "Brackley, UK", engine: "Mercedes", founded: 2010 },
  { id: 4, name: "AlphaTauri", base: "Faenza, IT", engine: "Honda", founded: 2006 },
];

const drivers = [
  { id: 1, name: "Charles Leclerc", teamId: 1, nationaly: "Monaco" },
  { id: 2, name: "Carlos Sainz", teamId: 1, nationaly: "Spain" },
  { id: 3, name: "Lando Norris", teamId: 2, nationaly: "UK" },
  { id: 4, name: "Daniel Ricciardo", teamId: 2, nationaly: "Australia" },
  { id: 5, name: "Lewis Hamilton", teamId: 3, nationaly: "UK" },
  { id: 6, name: "George Russell", teamId: 3, nationaly: "UK" },
  { id: 7, name: "Yuki Tsunoda", teamId: 4, nationaly: "Japan" },
  { id: 8, name: "Pierre Gasly", teamId: 4, nationaly: "France" }, 
];

server.get("/teams", async (request, response) => {
  response.type("application/json").code(200);
  return {teams};
});

server.get("/drivers", async (request, response) => {
  response.type("application/json").code(200);
  return {drivers};
});

server.get("/teams/:id", async (request, response) => {
  const { id } = request.params as { id: string };
  const team = teams.find(team => team.id === parseInt(id));
  if (!team) {
    response.code(404).send({ error: "Team not found" });
  } else {
    response.type("application/json").code(200);
    return team;
  }
});

server.get("/drivers/:id", async (request, response) => {
  const { id } = request.params as { id: string };
  const driver = drivers.find(driver => driver.id === parseInt(id));
  if (!driver) {
    response.code(404).send({ error: "Driver not found" });
  } else {
    response.type("application/json").code(200);
    return driver;
  }
});

server.listen({ port: 3333 }, (err, address) => {
  console.log(`Server initialized`);
})