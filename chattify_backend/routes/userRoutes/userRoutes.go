package routes

import (
	"github.com/RishabhBajpai97/chattify_backend/controllers"
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/websocket/v2"
)

func GetUserRoutes(app *fiber.App) {
	
	app.Get("/", controllers.Index)
	app.Post("/user/signup", controllers.SignUp)
	app.Post("/user/login", controllers.Login)
	app.Post("/user/sendOtp", controllers.SendOtp)
	app.Post("/user/verifyOtp", controllers.VerifyOtp)
	//Websocket Route
	app.Use( func(c *fiber.Ctx) error {
		// IsWebSocketUpgrade returns true if the client
		// requested upgrade to the WebSocket protocol.
		if websocket.IsWebSocketUpgrade(c) {
			c.Locals("allowed", true)
			return c.Next()
		}
		return fiber.ErrUpgradeRequired
	})
	app.Get("/ws", websocket.New(controllers.WsEndpoint))

}
