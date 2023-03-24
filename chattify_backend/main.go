package main

import (
	routes "github.com/RishabhBajpai97/chattify_backend/routes/userRoutes"
	"github.com/gofiber/fiber/v2"
)
func main(){
	app:= fiber.New();
	routes.GetUserRoutes(app)
	app.Listen(":3000")
}